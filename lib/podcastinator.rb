require "optparse"
require "erb"
require "digest/md5"
require "time"
require "date"
require "pp"
require "yaml"
require "uri"

require "nokogiri"
require "taglib"
require "mime-types"

require "podcastinator/version"
require "podcastinator/extensions"
require "podcastinator/feed"
require "podcastinator/generator"

module Podcastinator

  def self.start(options = self.parse_cli_options)
    feed = Podcastinator::FileFeed.new(options)
    xml  = Podcastinator::Generator.new(feed).to_xml

    if options[:output]
      File.open(options[:output], "w") do |f|
        f.puts(xml)
      end
    else
      puts xml
    end
  end

  def self.parse_cli_options
    options = {
      :path => Dir.pwd,
    }

    OptionParser.new do |opts|
      opts.banner = "Usage: podcastinator [options] [audio files ...]"

      opts.on("-o", "--output [FILENAME]", "Write the XML to the specified file") do |filename|
        options[:output] = filename
      end

      opts.on("-r", "--root [PATH]", "The root path in the URL to access the audio files") do |path|
        options[:path] = path
      end
    end.parse!

    add_channel_yml(options)

    options
  end

  def self.add_channel_yml(options)
    yml_filename = File.join(options[:path], "channel.yml")
    return unless File.file? yml_filename

    yml_content = File.read(yml_filename)
    yml_hash    = YAML.load(yml_content)

    yml_hash.each do |key, value|
      options[key.to_sym] ||= value
    end
  end

end
