
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

  # If the user changes the size then input anything other  
  # than 's', 'c', or 'q', their width/height will still be saved
  tempWidth = width
  tempHeight = height
  
  print "Please enter your choice: "
  mainInput = gets.chomp.downcase
  if mainInput == "s"
    get_board(width, height)
  elsif mainInput == "c"
    # Prevent the width and height to be zero
    loop do
      print "Width (Currently #{width})? : "
      getWidth = gets.chomp.to_i
      tempWidth = getWidth
      print "Height (Currently #{height})? : "
      getHeight = gets.chomp.to_i
      tempHeight = getHeight  
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
    puts
    main_menu(tempWidth, tempHeight, highscore) 
  end
end

def get_board(width, height)
  sameColor = 0
  totalBlock = 0
  
  board = Array.new(width) { Array.new(height) }
  (0...height).each do |row|
    (0...width).each do |column| 
      board[row][column] = rand(0..5)   
      case board[row][column]
        when 0
          print "  ".colorize(:background => :red)
        when 1
          print "  ".colorize(:background => :blue)
        when 2
          print "  ".colorize(:background => :green)
        when 3
          print "  ".colorize(:background => :yellow)
        when 4
          print "  ".colorize(:background => :cyan)
        when 5 
          print "  ".colorize(:background => :magenta)
      end
      
      # Total number of blocks that is same color with the top left block
      if (board[row][column] == board[0][0])
        sameColor += 1
        totalBlock += 1
      else 
        totalBlock += 1
      end
    end
    puts
  end
  
  # Calculate the staring completion percentage
  startCompletion = (sameColor * 100.0 / totalBlock) 
  update_and_check(0, startCompletion)
end

def update_and_check(turns, completion)
  puts "Number of turns: #{turns}"
  puts "Current completion: #{completion.round}%"
  print "Choose a colour: "
  colourInput = gets.chomp.to_s
end


#-----Main program-----# 
# Splash screen, run once
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

# Start
main_menu(14, 9, 0)
