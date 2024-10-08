require './cast.rb'
require './window.rb'

def main
  width = 30
  height = 30

  window = DisplayWindow.new(width, height)

  previous_time = Time.now
  delta_time = 0.0
  frame_rate = 12
  target_frame_time = 1.0 / frame_rate

  loop do
    current_time = Time.now
    delta_time += current_time - previous_time
    previous_time = current_time

    while delta_time >= target_frame_time
      window.update
      delta_time -= target_frame_time
    end

    blob = window.render_to_blob
    image = blob_to_rgba(blob, width, height)
    ansi = rgba_to_ansi(image)
    display(ansi)

    sleep_time = target_frame_time - (Time.now - current_time)
    sleep(sleep_time) if sleep_time > 0

    system("clear")
  end

end

main
