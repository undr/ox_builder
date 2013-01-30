# OxBuilder

XML builder with using ox. Fast and convenient DSL.

## Installation

Add this line to your application's Gemfile:

    gem 'ox_builder'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ox_builder

## Usage

```ruby
  Ox::Builder.document do |document|
    document.element(
    'rss', 'xmlns:dc' => 'http://purl.org/dc/elements/1.1/', 'xmlns:atom' => 'http://www.w3.org/2005/Atom',
    'xmlns:media' => 'http://search.yahoo.com/mrss/', 'xmlns:content' => 'http://purl.org/rss/1.0/modules/content/',
    'xmlns:itunes' => 'http://www.itunes.com/dtds/podcast-1.0.dtd', 'version' => '2.0'
  ) do |rss|
      rss.element('channel') do |channel|
        description(channel)

        Post.all do |post|
          channel_item(post)
        end
      end
    end
  end

  def description node
    node.element('title', 'Title of channel')
    node.element('link', 'http://www.example.com')
    node.element('description', 'Description of channel')
    node.element('language', 'ru')
    node.element('copyright', 'copyright')
  end

  def channel_post node, post
    node.element('item') do |item|
      node.element('title', post.title)
      node.element('link', post.permalink)
      node.element('guid', post.permalink)
      node.element('pubDate', post.published_at)
      node.element('description', post.description)
      node.element('category', post.category)
      mode.element('enclosure',  url: post.image.url, type: 'image/jpeg', length: post.image.size)
    end
  end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
