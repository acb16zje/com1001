
# Required gems
require 'console_splash'
require 'colorize'

# Main menu
def main_menu(width, height, highscore)
  puts "Main menu"
  puts "s = Start game"
  puts "c = Change size"
  puts "q = Quit game"
  
  if highscore == 0
    puts "No games played yet."
  else
    puts "Best game: #{highscore} turns."
  end

  print "Please enter your choice: "
  mainInput = gets.chomp.downcase
  if mainInput == "s"
    get_board(14, 9)
  elsif mainInput == "c"
    print "Width (Currently #{width})? : "
    getWidth = gets.chomp.to_i
    print "Height (Currently #{height})? : "
    getHeight = gets.chomp.to_i
    if (getWidth != width || getHeight != height)
      main_menu(getWidth, getHeight, 0)
    else (getWidth == width && getHeight == height)
      main_menu(width, height, highscore)
    end
  else mainInput == "q"
    exit
  end
end

def get_board(width, height)
  # TODO: Implement this method
  #
  # This method should return a two-dimensional array.
  # Each element of the array should be one of the
  # following values (These are "symbols", you can use
  # them like constant values):
  # :red
  # :blue
  # :green
  # :yellow
  # :cyan
  # :magenta
  #
  # It is important that this method is used because
  # this will be used for checking the functionality
  # of your implementation.
end

# TODO: Implement everything else as described in the
#       assignment brief.

# Splash screen
splashScreen = ConsoleSplash.new(13, 40) #=> 13 lines, 40 columns
splashScreen.write_header("Welcome to Flood-It", "Eng Zer Jun", "1.0")
splashScreen.write_center(-3, "Press <enter> to continue")
splashScreen.write_horizontal_pattern("*")
splashScreen.write_vertical_pattern("*")
splashScreen.splash
puts
loop do
  enter = gets
  break if enter == "\n"
end
main_menu(14, 9, 0)

