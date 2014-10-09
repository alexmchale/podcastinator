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
            xml.title(feed.title)
            xml.link(feed.url)
            xml.description(feed.description)
            xml["itunes"].summary(feed.description)
            xml["itunes"].image(href: feed.image_url)
            xml.generator("Podcastinator #{ Podcastinator::VERSION }")

            # Optional channel attributes
            xml.language(feed.language) if feed.language
            xml.copyright(feed.copyright) if feed.copyright
            xml.subtitle(feed.subtitle) if feed.subtitle
            xml.author(feed.author) if feed.author
            xml["itunes"].keywords([ feed.keywords ].flatten.compact.join(",")) if feed.keywords

            # Owner details
            if feed.owner_name || feed.owner_email
              xml["itunes"].owner do
                xml["itunes"].name(feed.owner_name)
                xml["itunes"].email(feed.owner_email)
              end
            end

            # Category details

            # Explicit flag

            # Channel items
            feed.items.each do |item|
              xml.item do
                xml.title(item.title)
                xml["itunes"].author(item.author)
                xml["itunes"].subtitle(item.subtitle) if item.subtitle
                xml["itunes"].summary(item.summary) if item.summary
                xml["itunes"].image(href: item.image_url || feed.image_url)
                xml.enclosure(url: item.url, length: item.file_size, type: item.mime_type)
                xml.guid(item.guid, isPermaLink: item.is_guid_permalink?)
                xml.pubDate(if item.time.respond_to?(:iso8601) then item.time.iso8601 else item.time.to_s end)
                xml["itunes"].duration(item.duration.to_i)
                xml["itunes"].keywords([ item.keywords ].flatten.compact.join(",")) if item.keywords
              end
            end
          end
        end
      end
    end

    def to_xml
      xml_builder.to_xml
    end

    def self.to_xml(feed)
      new(feed).to_xml
    end

  end

end
