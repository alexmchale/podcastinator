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

### On the command line

From within a directory that has audio files, running `podcastinator` alone
will generate an `index.xml` based on the MP3 files in your current directory.

### As an API

#### Creating the podcast XML from data in memory

```ruby
class Feed < Podcastinator::Feed
  def initialize(options = {})
    super
    @items_hash = options[:items_hash]
  end
  def items
  end
end
```

#### Creating the podcast XML from audio files on disk

## Contributing

1. Fork it ( https://github.com/[my-github-username]/podcastinator/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
