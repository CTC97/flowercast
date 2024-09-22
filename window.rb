require 'gosu'

class DisplayWindow < Gosu::Window
  def initialize(width, height)
    @width = width
    @height = height
    super(@width, @height)

    @square_size = 4
    @x = (@width - @square_size) / 2
    @y = (@height - @square_size) / 2
    @speed = 10
    @direction = 1
  end

  def update
    @x += @speed * @direction

    if @x <= 0 || @x >= @width - @square_size
      @direction *= -1
    end
  end

  def draw
    draw_square(@x, @y, @square_size, Gosu::Color::FUCHSIA)
  end

  def draw_square(x, y, size, color)
    Gosu.draw_rect(x, y, size, size, color)
  end

  def render(path)
    Gosu.render(@width, @height, retro: true) do
      draw
    end.save("#{path}")
  end
end
