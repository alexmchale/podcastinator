require 'test_helper'

class GeneratedFeedTest < Minitest::Test

  def test_empty_fields
    feed =
      Podcastinator::Feed.new({
        :items => [
          Podcastinator::Feed::Item.new({
          }),
        ]
      })

    expected_xml = <<-XML.gsub(/^\s{6}/, "")
      <?xml version="1.0"?>
      <rss xmlns:itunes="http://www.itunes.com/dtds/podcast-1.0.dtd" version="2.0">
        <channel>
          <title/>
          <link/>
          <description/>
          <itunes:summary/>
          <itunes:image href=""/>
          <generator>Podcastinator #{ Podcastinator::VERSION }</generator>
          <item>
            <title/>
            <itunes:author/>
            <itunes:image href=""/>
            <enclosure url="" length="" type=""/>
            <guid isPermaLink="false"/>
            <pubDate/>
            <itunes:duration>0</itunes:duration>
          </item>
        </channel>
      </rss>
    XML

    generated_xml = Podcastinator::Generator.new(feed).to_xml

    assert_equal expected_xml.strip, generated_xml.strip
  end

  def test_all_fields
    feed =
      Podcastinator::Feed.new({
      :author      => "Mr. Bob Example",
        :copyright   => "Copyright 2001 Bob Example Inc",
        :description => "This is Bob's podcast. Do not mess with Bob.",
        :image_url   => "http://example.com/podcast.png",
        :keywords    => [ "bob", "example" ],
        :language    => "English",
        :owner_name  => "Bob Example",
        :owner_email => "bob@example.com",
        :subtitle    => "Don't mess with the bob.",
        :title       => "Bob's EXTREME Podcast",
        :url         => "http://example.com/podcast.xml",

        :items => [
          Podcastinator::Feed::Item.new({
            :author    => "Sue Example",
            :duration  => "127",
            :file_size => "92812",
            :filename  => "episode-128.mp3",
            :guid      => "http://example.com/episodes/128.html",
            :image_url => "http://example.com/episodes/128.png",
            :keywords  => [ "sue", "example" ],
            :mime_type => "audio/mp3",
            :subtitle  => "Sue's episode, it's great!",
            :summary   => "This episode is dedicated to Sue.",
            :time      => Time.parse("April 21, 2010 6:24pm CDT").utc,
            :title     => "Episode 128",
            :url       => "http://example.com/episodes/128.mp3",
          }),
          Podcastinator::Feed::Item.new({
            :author    => "Ms. Sue Example",
            :duration  => "256",
            :file_size => "92912",
            :filename  => "episode-129.mp3",
            :guid      => "http://example.com/episodes/129.html",
            :image_url => "http://example.com/episodes/129.png",
            :keywords  => [ "sue", "example", "two" ],
            :mime_type => "audio/mp3",
            :subtitle  => "Sue's second episode, it's great!",
            :summary   => "This second episode is dedicated to Sue.",
            :time      => Time.parse("April 22, 2010 6:24pm CDT").utc,
            :title     => "Episode 129",
            :url       => "http://example.com/episodes/129.mp3",
          }),
        ]
      })

    expected_xml = <<-XML.gsub(/^\s{6}/, "")
      <?xml version="1.0"?>
      <rss xmlns:itunes="http://www.itunes.com/dtds/podcast-1.0.dtd" version="2.0">
        <channel>
          <title>Bob's EXTREME Podcast</title>
          <link>http://example.com/podcast.xml</link>
          <description>This is Bob's podcast. Do not mess with Bob.</description>
          <itunes:summary>This is Bob's podcast. Do not mess with Bob.</itunes:summary>
          <itunes:image href="http://example.com/podcast.png"/>
          <generator>Podcastinator #{ Podcastinator::VERSION }</generator>
          <language>English</language>
          <copyright>Copyright 2001 Bob Example Inc</copyright>
          <subtitle>Don't mess with the bob.</subtitle>
          <author>Mr. Bob Example</author>
          <itunes:keywords>bob,example</itunes:keywords>
          <itunes:owner>
            <itunes:name>Bob Example</itunes:name>
            <itunes:email>bob@example.com</itunes:email>
          </itunes:owner>
          <item>
            <title>Episode 128</title>
            <itunes:author>Sue Example</itunes:author>
            <itunes:subtitle>Sue's episode, it's great!</itunes:subtitle>
            <itunes:summary>This episode is dedicated to Sue.</itunes:summary>
            <itunes:image href="http://example.com/episodes/128.png"/>
            <enclosure url="http://example.com/episodes/128.mp3" length="92812" type="audio/mp3"/>
            <guid isPermaLink="true">http://example.com/episodes/128.html</guid>
            <pubDate>2010-04-21T23:24:00Z</pubDate>
            <itunes:duration>127</itunes:duration>
            <itunes:keywords>sue,example</itunes:keywords>
          </item>
          <item>
            <title>Episode 129</title>
            <itunes:author>Ms. Sue Example</itunes:author>
            <itunes:subtitle>Sue's second episode, it's great!</itunes:subtitle>
            <itunes:summary>This second episode is dedicated to Sue.</itunes:summary>
            <itunes:image href="http://example.com/episodes/129.png"/>
            <enclosure url="http://example.com/episodes/129.mp3" length="92912" type="audio/mp3"/>
            <guid isPermaLink="true">http://example.com/episodes/129.html</guid>
            <pubDate>2010-04-22T23:24:00Z</pubDate>
            <itunes:duration>256</itunes:duration>
            <itunes:keywords>sue,example,two</itunes:keywords>
          </item>
        </channel>
      </rss>
    XML

    generated_xml = Podcastinator::Generator.new(feed).to_xml

    assert_equal expected_xml.strip, generated_xml.strip
  end

end
