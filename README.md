# Podcastinator

This is a gem for generating the XML for a podcast feed.

## Installation

Add this line to your application's Gemfile:

    gem 'podcastinator'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install podcastinator

## Usage

Create a Feed object with items

```ruby
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

    :items => [{
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
    }, {
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
    }],
  })
```

Then extract the XML from the feed object

```ruby
xml = feed.to_xml
```

The XML generator can accept any object that responds to the following methods:

```
author
copyright
description
image_url
items
keywords
language
owner_name
owner_email
subtitle
title
url
```

The `items` value should be an array of objects that respond to the following methods:

```
author
duration
file_size
guid
image_url
keywords
mime_type
subtitle
summary
time
title
url
```

## Contributing

1. Fork it ( https://github.com/alexmchale/podcastinator/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
