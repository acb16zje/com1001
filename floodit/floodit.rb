
# Required gems
require 'console_splash'
require 'colorize'

# Splash screen
def splash_screen
  splash = ConsoleSplash.new(13, 40) #=> 13 lines, 40 columns
  splash.write_header("Welcome to Flood-It", "Eng Zer Jun", "1.0")
  splash.write_center(-3, "Press <enter> to continue")
  splash.write_horizontal_pattern("*")
  splash.write_vertical_pattern("*")
  splash.splash
  puts
  loop do
    enter = gets
    break if enter == "\n"
  end
  # Call the main menu, default width is 14, height is 9, no score
  main_menu(14, 9, 0)
end

# Main menu
def main_menu(width, height, score)
  puts "Main menu"
  puts "s = Start game"
  puts "c = Change size"
  puts "q = Quit game"

  if score == 0
    puts "No games played yet."
  elsif score
    puts "Best game: #{score}"
  end

  # Give a value to the variables
  get_width = width
  get_height = height
  
  print "Please enter your choice: "
  main_input = gets.chomp.downcase
  if main_input == "s"
    get_board(width, height)
  elsif main_input == "c"
    # Prevent the width and height to be less than 1
    loop do
      print "Width (Currently #{width})? : "
      get_width = gets.chomp.to_i
      print "Height (Currently #{height})? : "
      get_height = gets.chomp.to_i
      if get_width <= 1 || get_height <= 1
        puts "The width and height must greater than 1. Please enter again."
      elsif get_width != width || get_height != height
        puts
        main_menu(get_width, get_height, 0 )
        break
      elsif get_width == width && get_height == height
        puts
        main_menu(width, height, score)
        break
      end
    end
  elsif main_input == "q"
    exit
  else
    # If the user changes the size then input anything other
    # than 's', 'c', or 'q', their width/height will still be saved
    puts
    main_menu(get_width, get_height, score)
  end
end

def get_board(width, height)
  board = Array.new(height) { Array.new(width) }

  (0...height).each do |row|
    (0...width).each do |column|
      board[row][column] = rand(0..5)
      case board[row][column]
        when 0
          print "  ".colorize(:background => :red)
        when 1
          print "  ".colorize(:background => :green)
        when 2
          print "  ".colorize(:background => :blue)
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
  calculate(board, 0)
end

# Calculate the completion percentage
def calculate(board, turns)
  same_color = 0
  blocks = 0
  (0...board.length).each do |row|
    (0...board[row].length).each do |column|
      if board[row][column] == board[0][0]
        same_color += 1
        blocks += 1
      else
        blocks += 1
      end
    end
  end
  completion = (same_color * 100 / blocks)

  # Check if the whole board has the same colour
  if completion == 100
    puts "You have won after #{turns} turns"
    puts "Press <enter> to return to main menu"
    loop do
      user_input = gets
      break if user_input == "\n"
    end
    main_menu(board.length, board[0].length, turns)
  else
    stats(board, turns, completion)
  end
end

# Update the number of turns and completion percentage
# The number of turns is increased after calling update_board
def stats(board, turns, completion)
  puts "Number of turns: #{turns}"
  puts "Current completion: #{completion}%"
  puts " r = Red, g = Green, b = Blue, y = Yellow, c = Cyan, m = Magenta"
  
  loop do
    print "Choose a colour: "
    colour = gets.chomp.downcase.to_s
    if colour == "r" || colour == "g" || colour == "b" ||
       colour == "c" || colour == "y" || colour == "m"
      puts
      update_and_check(board, turns, completion, colour)
      break
    end
  end
end

def update_and_check(board, turns, completion, colour)
  # Save the top left colour before changing,
  # and use it to check and mark neighbour blocks
  old_colour = board[0][0]
  check_neighbours(board, 0, 0, old_colour)

  # First: change the top left block to the new colour
  case colour
    when "r"
      board[0][0] = 0
    when "g"
      board[0][0] = 1
    when "b"
      board[0][0] = 2
    when "c"
      board[0][0] = 3
    when "y"
      board[0][0] = 4
    when "m"
      board[0][0] = 5
  end
  
  # Print out the new board
  (0...board.length).each do |row|
    (0...board[row].length).each do |column|
      if board[row][column] == "mark"
        board[row][column] = board[0][0]
      end
      case board[row][column]
        when 0
          print "  ".colorize(:background => :red)
        when 1
          print "  ".colorize(:background => :green)
        when 2
          print "  ".colorize(:background => :blue)
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
  calculate(board, turns)
end

# Recursive method of marking blocks
def mark(board, row, column, colour)
  if board[row][column] == colour
    board[row][column] = "mark"
    check_neighbours(board, row, column, colour)
  end
end

# Recursive method of checking blocks
def check_neighbours(board, row, column, colour)
  # If not the first row, check top block
  if row > 0
    mark(board, row - 1, column, colour)
  end
  # If not the last row, check bottom block
  if row < board.length - 1
    mark(board, row + 1, column, colour)
  end
  # If not the first column, check left block
  if column > 0
    mark(board, row, column - 1, colour)
  end
  # If not the last column, check right block
  if column < board[0].length - 1
    mark(board, row, column + 1, colour)
  end
end

#-----Main program-----#
# Start
splash_screen
