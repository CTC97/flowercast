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
    @border_thickness = 1

    @background_color = Gosu::Color::WHITE
  end

  def update
    @x += @speed * @direction

    if @x <= 0 || @x >= @width - @square_size
      @direction *= -1
    end
  end

  def draw
    Gosu.draw_rect(0, 0, width, height, @background_color)
    draw_border(Gosu::Color::WHITE)
    draw_square(@x, @y, @square_size, Gosu::Color::FUCHSIA)
  end

  def draw_square(x, y, size, color)
    Gosu.draw_rect(x, y, size, size, color)
  end

  def draw_border(color)
    Gosu.draw_rect(0, 0, @width, @border_thickness, color)
    Gosu.draw_rect(0, @height - @border_thickness, @width, @border_thickness, color)
    Gosu.draw_rect(0, 0, @border_thickness, @height, color)
    Gosu.draw_rect(@width - @border_thickness, 0, @border_thickness, @height, color)
  end

  def render_to_blob
    Gosu.render(@width, @height, retro: true) do
      draw
    end.to_blob
  end
end
