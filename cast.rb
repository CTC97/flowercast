require 'chunky_png'

def blob_to_rgba(blob, width, height)
  image = ChunkyPNG::Image.new(width, height)

  (0...height).map do |y|
    (0...width).map do |x|
      idx = (y * width + x) * 4  # RGBA, so 4 bytes per pixel
      r = blob[idx].ord
      g = blob[idx + 1].ord
      b = blob[idx + 2].ord
      a = blob[idx + 3].ord
      image[x, y] = ChunkyPNG::Color.rgba(r, g, b, a)
    end
  end

  (0...image.height).map do |y|
    (0...image.width).map do |x|
      pixel = image[x, y]
      [ChunkyPNG::Color.r(pixel), ChunkyPNG::Color.g(pixel), ChunkyPNG::Color.b(pixel), ChunkyPNG::Color.a(pixel)]
    end
  end
end

def file_to_rgba(path, width, height)
  image = ChunkyPNG::Image.from_file(path)
  resized_image = image.resample_nearest_neighbor(width, height)

  (0...resized_image.height).map do |y|
    (0...resized_image.width).map do |x|
      pixel = resized_image[x, y]
      [ChunkyPNG::Color.r(pixel), ChunkyPNG::Color.g(pixel), ChunkyPNG::Color.b(pixel), ChunkyPNG::Color.a(pixel)]
    end
  end
end

def rgba_to_ansi(rgba_pixels)
  rgba_pixels.map do |row|
    row.map do |pixel|
      # currently supports r,g,b ANSI, but not all terminals support this
      # look into 256 color support
      if (pixel[0..2] == [0,0,0])
        "\033[49m"
      else
        "\e[38;2;#{pixel[0]};#{pixel[1]};#{pixel[2]}m"
      end
    end
  end
end

def display(ansi_image)
  ansi_image.map do |row|
    row.map do |pixel|
      if (pixel == "\e[49m")
        print " "
      else
        print "#{pixel}፨ "
      end
    end
    puts
  end
end
