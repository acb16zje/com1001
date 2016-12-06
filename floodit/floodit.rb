
# Required gems
require 'console_splash'
require 'colorize'

# Splash screen
def splash_screen
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
  
  # Call the main menu, default width is 14, height is 9, no highscore
  main_menu(14, 9 ,0)
end

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

  # Give a value to the variables
  getWidth = width
  getHeight = height
  
  print "Please enter your choice: "
  mainInput = gets.chomp.downcase
  if mainInput == "s"
    get_board(width, height)
  elsif mainInput == "c"
    # Prevent the width and height to be zero
    loop do
      print "Width (Currently #{width})? : "
      getWidth = gets.chomp.to_i
      print "Height (Currently #{height})? : "
      getHeight = gets.chomp.to_i
      if (getWidth == 0 || getHeight == 0)
        puts "The width and height can't be zero. Please enter again."
      elsif (getWidth != width || getHeight != height)
        puts
        main_menu(getWidth, getHeight, 0)
        break
      elsif (getWidth == width && getHeight == height)
        puts
        main_menu(width, height, highscore)
        break
      end
    end
  elsif mainInput == "q"
    exit
  else
    # If the user changes the size then input anything other
    # than 's', 'c', or 'q', their width/height will still be saved
    puts
    main_menu(getWidth, getHeight, highscore)
  end
end

def get_board(width, height)
  $board = Array.new(width) { Array.new(height) }
  (0...height).each do |row|
    (0...width).each do |column|
      $board[row][column] = rand(0..5)
      case $board[row][column]
        when 0
          print "  ".colorize(:background => :red)
        when 1
          print "  ".colorize(:background => :blue)
        when 2
          print "  ".colorize(:background => :green)
        when 3
          print "  ".colorize(:background => :cyan)
        when 4
          print "  ".colorize(:background => :yellow)
        when 5
          print "  ".colorize(:background => :magenta)
      end
    end
    puts
  end
  turns_completion(width, height, 0)
end

# Calculate total number of blocks, the number of blocks that is 
# same colour with the top left block and the completion percentage
def turns_completion(width, height, turns)
  sameColor = 0
  totalBlock = 0
  (0...height).each do |row|
    (0...width).each do |column|
      if ($board[row][column] == $board[0][0])
        sameColor += 1
        totalBlock += 1
      else
        totalBlock += 1
      end
    end
  end
  completion = (sameColor * 100.0 / totalBlock)
  update(width, height, turns, completion)
end

# Update the number of turns and completion percentage
# Increase the number of turns after the update_board has been called
def update(width, height, turns, completion)
  puts "Number of turns: #{turns}"
  puts "Current completion: #{completion.round}%"
  puts " r = Red, g = Green, b = Blue, y = Yellow, c = Cyan, m = Magenta"
  
  loop do
    print "Choose a colour: "
    colourInput = gets.chomp.to_s
    if (colourInput == "r" || colourInput == "g" || colourInput == "b" ||
        colourInput == "c" || colourInput == "y" || colourInput == "m")
      update_board(width, height, turns, colourInput)
      break
    end
  end
end

def update_board(width, height, turns, input)
  # First: update the top left block to new colour
  case input
    when "r"
      $board[0][0] = 0
    when "g"
      $board[0][0] = 1
    when "b"
      $board[0][0] = 2
    when "c"
      $board[0][0] = 3
    when "y"
      $board[0][0] = 4
    when "m"
      $board[0][0] = 5
  end
  
  (0...height).each do |row|
    (0...width).each do |column|
      case $board[row][column]
        when 0
          print "  ".colorize(:background => :red)
        when 1
          print "  ".colorize(:background => :blue)
        when 2
          print "  ".colorize(:background => :green)
        when 3
          print "  ".colorize(:background => :cyan)
        when 4
          print "  ".colorize(:background => :yellow)
        when 5
          print "  ".colorize(:background => :magenta)
      end
    end
    puts
  end
  turns += 1
  turns_completion(width, height, turns)
end

def is_solved
  
end

#-----Main program-----# 
# Start
splash_screen
