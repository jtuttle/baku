# Baku

Baku provides a simple Entity Component System framework for use with Ruby game engines. It has been tested with [Gosu](https://www.libgosu.org/ruby.html), but should be flexible enough to work with any Ruby project that has a game loop.

Baku is still very much a work in progress. There are undoubtedly bugs. I will be continually iterating and improving on it as I use it for my personal game development projects. Enjoy!

The [Baku wiki](https://github.com/jtuttle/baku/wiki) includes a [quick start guide](https://github.com/jtuttle/baku/wiki/quick-start-guide) if you're already familiar with the ECS approach. If not, there is also a descriptive [tutorial](https://github.com/jtuttle/baku/wiki/tutorial) that will cover ECS concepts while walking you through setting up Gosu with Baku.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'baku'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install baku

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run
`rake spec` to run the tests. You can also run `bin/console` for an interactive
prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To
release a new version, update the version number in `version.rb`, and then run
`bundle exec rake release`, which will create a git tag for the version, push git
commits and tags, and push the `.gem` file to
[rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/jtuttle/baku.

## License

The gem is available as open source under the terms of the
[MIT License](http://opensource.org/licenses/MIT).
