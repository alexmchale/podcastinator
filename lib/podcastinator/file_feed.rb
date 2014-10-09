module Podcastinator

  class FileFeed < Feed

    attr_reader :local_path

    def initialize(options = {})
      super

      @local_path = options[:local_path]
    end

    def items
      @items ||=
        Dir.chdir(local_path) do
          Dir[*FileItem.globs].uniq.map do |filename|
            FileItem.new(self, filename)
          end
        end
    end

    class FileItem < Item

      attr_reader *%i(
        author
        filename
        image_url
        local_filename
        subtitle
        time
        title
        url
        file_size
        mime_type
        duration
        summary
      )

      def initialize(feed, filename)
        @feed           = feed
        @filename       = filename
        @local_filename = File.join(feed.local_path, filename)
        @url            = "#{ feed.url }/#{ URI.escape @filename.to_s }".gsub("//", "/")

        @image_url =
          if File.file? File.join(feed.local_path, "#{ filename }.jpg")
            "#{ @url }.jpg"
          else
            feed.image_url
          end

        TagLib::FileRef.open(local_filename) do |fileref|
          tag      = fileref.tag

          @title    = tag.title
          @author   = tag.artist
          @album    = tag.album
          @track    = if tag.track.present? && tag.track != 0 then tag.to_s.track[/^\d+/] end
          @subtitle = if author.present? && @track.present? then %[#{ album } ##{ track }] end
          @duration = fileref.audio_properties.length
        end
      end

      def mime_type
        case File.extname(filename).downcase
        when ".mp3" then "audio/mpeg"
        else raise UnknownMimeType, "podcastinator can't handle #{ filename }"
        end
      end

      def guid
        md5 = Digest::MD5.new

        File.open(local_filename, 'rb') do |io|
          while (buf = io.read(4096)) && (buf.length > 0)
            md5.update(buf)
          end
        end

        md5.to_s
      end

      def is_guid_permalink?
        false
      end

      def time
        @time || File.mtime(local_filename)
      end

      def keywords
        []
      end

      def self.mime_types
        {
          "mp3" => "audio/mpeg",
        }
      end

      def self.globs
        mime_types.keys.map { |ext| "**/*.#{ ext }" }
      end

      def self.build(feed, files)
        files.map do |filename|
          title, subtitle, author, time, image_url = nil

          TagLib::FileRef.open(local_filename) do |fileref|
            tag      = fileref.tag

            title    = tag.title
            author   = tag.artist
            album    = tag.album
            track    = if tag.track.present? && tag.track != 0 then tag.to_s.track[/^\d+/] end
            subtitle = if album.present? && track.present? then %[#{ album } ##{ track }] end
          end

          new(feed, filename, title, subtitle, author, time, image_url)
        end
      end

    end

  end

end
