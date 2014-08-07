module Podcastinator

  class Generator

    attr_accessor :feed

    def initialize(feed)
      @feed = feed
    end

    def xml_builder
      Nokogiri::XML::Builder.new do |xml|
        xml.rss("xmlns:itunes" => "http://www.itunes.com/dtds/podcast-1.0.dtd", "version" => "2.0") do
          xml.channel do
            # Required channel attributes
            xml.title feed.title
            xml.link feed.url
            xml.description feed.description
            xml["itunes"].summary feed.description
            xml["itunes"].image(href: feed.image_url)
            xml.generator "Podcastinator #{ Podcastinator::VERSION }"

            # Optional channel attributes
            xml.language feed.language if feed.language.present?
            xml.copyright feed.copyright if feed.copyright.present?
            xml.subtitle feed.subtitle if feed.subtitle.present?
            xml.author feed.author if feed.author.present?
            xml["itunes"].keywords feed.keywords.join(",") if feed.keywords.present?

            # Owner details
            if feed.owner
              xml["itunes"].owner do
                xml["itunes"].name feed.owner.name
                xml["itunes"].email feed.owner.email
              end
            end

            # Category details

            # Explicit flag

            # Channel items
            feed.items.each do |item|
              xml.item do
                xml.title item.title
                xml["itunes"].author item.author
                xml["itunes"].subtitle item.subtitle if item.subtitle.present?
                xml["itunes"].summary item.subtitle if item.subtitle.present?
                xml["itunes"].image(href: if item.image_url.present? then item.image_url else feed.image_url end)
                xml.enclosure(url: item.url, length: item.file_size, type: item.mime_type)
                xml.guid(item.guid, isPermaLink: "false")
                xml.pubDate item.time.iso8601
                xml["itunes"].duration item.duration.to_i
                xml["itunes"].keywords item.keywords.join(",") if item.keywords.present?
              end
            end
          end
        end
      end
    end

    def to_xml
      xml_builder.to_xml
    end

  end

end
