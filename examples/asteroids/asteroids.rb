require 'gosu'
require 'baku'
require 'pry'
require 'require_all'

require_relative 'game_config.rb'
require_relative 'entity_factory.rb'
require_all "components"
require_all "systems"

class Asteroids < Gosu::Window
  def initialize
    super GameConfig::SCREEN_WIDTH, GameConfig::SCREEN_HEIGHT
    self.caption = "Asteroids"

    @prev_ms = 0
    
    init_world
  end

  def init_world
    @world = create_world
    @player = EntityFactory.create_player(@world)

    create_starter_asteroid(100, 100)
    create_starter_asteroid(GameConfig::SCREEN_WIDTH - 100, 100)
    create_starter_asteroid(100, GameConfig::SCREEN_HEIGHT - 100)
    create_starter_asteroid(GameConfig::SCREEN_WIDTH - 100,
                            GameConfig::SCREEN_HEIGHT - 100)
  end

  def update
    current_ms = Gosu::milliseconds()
    delta_ms = current_ms - @prev_ms
    @prev_ms = current_ms
    @world.update(delta_ms)

    # Restart the game if the player dies.
    if @player.get_component(Components::PlayerStateComponent).dead
      @world.dispose
      init_world
    end
  end

  def draw
    @world.draw
  end

  private

  def create_world
    world = Baku::World.new

    # update systems
    world.add_system(Systems::InputSystem.new)
    world.add_system(Systems::LaserSystem.new)
    world.add_system(Systems::MovementSystem.new)
    world.add_system(Systems::ScreenWrapSystem.new)
    world.add_system(Systems::TimedDestroySystem.new)
    world.add_system(Systems::CollisionSystem.new)
    world.add_system(Systems::AsteroidSplitSystem.new)
    world.add_system(Systems::PlayerDeathSystem.new)

    # draw systems
    world.add_system(Systems::SpriteRenderSystem.new)
    #world.add_system(Systems::ColliderRenderSystem.new)

    world
  end

  def create_starter_asteroid(x, y)
    EntityFactory.create_asteroid(@world, 3, x, y)
  end
end

Asteroids.new.show
