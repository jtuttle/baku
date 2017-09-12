# Baku

Baku provides a simple Entity Component System framework for use with Ruby game
engines. It has been tested with [Gosu](https://www.libgosu.org/ruby.html), but
should be flexible enough to work with any Ruby project that has a game loop.

Baku is still very much a work in progress. There are undoubtedly bugs. I will
be continually iterating and improving on it as I use it for my personal game
development projects. Enjoy!

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'baku'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install baku

## Usage

Create components by overriding `Baku::Component` and calling `super()`. The
example component below simple stores the x and y coordinates of an entity in
a 2D space.

```
class TransformComponent < Baku::Component
  attr_accessor :x, :y

  def initialize(x, y)
    super()

    @x = x
    @y = y
  end
end
```

Create systems by overriding `Baku::System` and calling `super()` to specify the
components that an entity must possess in order for it to be processed by the
system. The example system below will only operate on entities that possess both
a `TransformComponent` and a `VelocityComponent`. You will also need to specify
whether the system will be run during the `:update` or `:draw` loop.

```
class MovementSystem < Baku::System
  def initialize
    super([TransformComponent, VelocityComponent], :update)
  end

  def process_entity(entity, transform, velocity)
    transform.x += velocity.x
    transform.y += velocity.y
  end
end
```

In your game initialization logic, create a `Baku::World` instance and register
any systems you want to use. In the below example, we register our example
system from above and create an entity that will be processed by the system:

```
def game_initialization
  @world = Baku::World.new
  @world.add_system(MovementSystem.new)

  entity = @world.create_entity
  entity.add_component(TransformComponent)
  entity.add_component(VelocityComponent)
end
```

In your game `update` and `draw` loops, call the `Baku::World` instance's
`update` and `draw` methods. You'll want to keep track of the millseconds
between frames and pass that to the `update` method if you're planning to
use the entity component system for anything that needs it.

```
def game_update_loop
  @world.update(delta_ms)
end

def game_draw_loop
  @world.draw
end
```

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
