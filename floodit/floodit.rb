
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
  # Highscore is set to 1000 so any score of first game could replace it
  main_menu(14, 9, 0, 1000)
end

# Main menu
def main_menu(width, height, score, highscore)
  puts "Main menu"
  puts "s = Start game"
  puts "c = Change size"
  puts "q = Quit game"

  # First time running the game or quit halfway without previous record
  if score == 0 && highscore == 1000
    puts "No games played yet."
  # Quit halfway with previous highscore record
  elsif score == 0 && highscore != 1000
    puts "Best game: #{highscore} turns"
  elsif score > 0
    if score <= highscore
      highscore = score
      puts "Best game: #{highscore} turns"
    elsif score > highscore
      puts "Best game: #{highscore} turns"
    end
  end

  print "Please enter your choice: "
  main_input = gets.chomp.downcase
  if main_input == "s"
    # Get the board and start the game with 0 turns
    board = get_board(width, height)
    puts
    print_board(board, 0, highscore)
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
        # Reset the highscore if size changes
        puts
        main_menu(get_width, get_height, 0, 1000)
        break
      elsif get_width == width && get_height == height
        puts
        main_menu(width, height, score, highscore)
        break
      end
    end
  elsif main_input == "q"
    exit
  else
    puts
    main_menu(width, height, score, highscore)
  end
end

# Return a new board when a new game starts
def get_board(width, height)
  start = Array.new(height) { Array.new(width) }
  (0...height).each do |r|
    (0...width).each do |c|
      start[r][c] = [:red, :green, :blue, :cyan, :yellow, :magenta].sample
    end
  end
  return start
end

# Print out the board
def print_board(board, turns, highscore)
  (0...board.length).each do |row|
    (0...board[row].length).each do |column|
      if board[row][column] == "mark"
        board[row][column] = board[0][0]
      end
      case board[row][column]
        when :red
          print "  ".colorize(:background => :red)
        when :green
          print "  ".colorize(:background => :green)
        when :blue
          print "  ".colorize(:background => :blue)
        when :cyan
          print "  ".colorize(:background => :cyan)
        when :yellow
          print "  ".colorize(:background => :yellow)
        when :magenta
          print "  ".colorize(:background => :magenta)
      end
    end
    puts
  end
  calculate(board, turns, highscore)
end

# Calculate the completion percentage
def calculate(board, turns, highscore)
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
    main_menu(board[0].length, board.length, turns, highscore)
  else
    stats(board, turns, completion, highscore)
  end
end

# Update the number of turns and completion percentage
# The number of turns is increased after calling update_board
def stats(board, turns, completion, highscore)
  puts "Number of turns: #{turns}"
  puts "Current completion: #{completion}%"
  puts " r = Red, g = Green, b = Blue, y = Yellow, c = Cyan, m = Magenta"
  
  loop do
    print "Choose a colour: "
    colour = gets.chomp.downcase.to_s
    # Prevent same colour input
    case colour
      when "r"
        colour = :red
      when "g"
        colour = :green
      when "b"
        colour = :blue
      when "c"
        colour = :cyan
      when "y"
        colour = :yellow
      when "m"
        colour = :magenta
    end
    if colour == board[0][0]
      puts "Please choose a different colour."
    elsif colour == "q"
      # Quit halfway, check whether have previous highscore record
      puts
      main_menu(board[0].length, board.length, 0, highscore)
    elsif colour == :red || colour == :green || colour == :blue ||
        colour == :cyan || colour == :yellow || colour == :magenta
      puts
      update_and_check(board, turns, highscore, colour)
      break
    end
  end
end

# Recursive method of checking and marking blocks
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

# After marking a block check back its neighbour blocks
def mark(board, row, column, colour)
  if board[row][column] == colour
    board[row][column] = "mark"
    check_neighbours(board, row, column, colour)
  end
end

# Main gameplay, updating the board after user input
def update_and_check(board, turns, highscore, colour)
  # Save the top left colour before changing,
  # and use it to check and mark neighbour blocks
  old_colour = board[0][0]
  check_neighbours(board, 0, 0, old_colour)

  # First: change the top left block to the new colour
  case colour
    when :red
      board[0][0] = :red
    when :green
      board[0][0] = :green
    when :blue
      board[0][0] = :blue
    when :cyan
      board[0][0] = :cyan
    when :yellow
      board[0][0] = :yellow
    when :magenta
      board[0][0] = :magenta
  end

  # Loop back to printing the board
  turns += 1
  print_board(board, turns, highscore)
end

#-----Main program-----#
# Start
splash_screen
