class Player
  attr_accessor :name, :type

  def initialize
  end

end

class Game
  @@cells = (1..9).to_a
  @@moves = 0

  def print_guide
    puts "#######################################"
    puts "### Welcome To My Tic-Tac-Toe Game! ###"
    puts "#######################################"
    puts "_______________________________________"
    puts nil
    puts "################ RULES ################"
    puts "Two players will take turns to mark the"
    puts " spaces on a 3x3 grid. The player who  "
    puts " succeeds in placing 3 of their marks  "
    puts "horizontally, verticallly, or diagonally"
    puts " wins the game. When there are no more "
    puts "spaces left to mark, it is considered a"
    puts "draw. To place a mark on the grid, type"
    puts "the number on the space you would like "
    puts "to mark, as shown below! Good luck! \n " 
    display_grid 
  end

  def display_grid
    print "| ", @@cells[0], " | ", @@cells[1], " | ", @@cells[2], " | ", "\n"
    puts "----+---+----"
    print "| ", @@cells[3], " | ", @@cells[4], " | ", @@cells[5], " | ", "\n"
    puts "----+---+----"
    print "| ", @@cells[6], " | ", @@cells[7], " | ", @@cells[8], " | ", "\n"
  end

  def get_details

    puts "Enter your name, player 1:"    
    @player1.name = gets.chomp

    loop do 
      puts "Would you like to play as 'X' or 'O'?"
      @player1.type = gets.chomp.upcase
      break if @player1.type  == 'X'|| @player1.type  == 'O'
    end

    puts "Enter your name, player 2:"
    @player2.name = gets.chomp
    @player2.type = @player1.type == 'X' ? @player2.type = 'O': @player2.type = 'X'

  end
  
  def initialize
    print_guide
    @player1 = Player.new
    @player2 = Player.new
    get_details
  end

  def start_game
    winner = nil
    display_grid
    while true
      puts "#{@player1.name}'s turn."
      @@cells[attack(@player1) - 1] = @player1.type
      @@moves += 1
      display_grid
      
      if won?
        winner = @player1
        break
      end
      
      if @@moves == 9
        break
      end
      puts "#{@player2.name}'s turn."
      @@cells[attack(@player2) - 1] = @player2.type
      @@moves += 1
      display_grid

      if won?
        winner = @player2
        break
      end
    end

    if winner == nil
      puts "It's a tie!"
    else
      puts "#{winner.name} won the game!"
    end
    restart?
  end

  def attack(player)
    loop do
      puts "Enter a position to attack, #{player.name}:"
      player_position = gets.chomp.to_i
      if @@cells.include? player_position
        return player_position
      end
    end
  end

  def won?
    for i in (0..2)
      i += i*2
      return true if @@cells[i]==@@cells[i+1] && @@cells[i+1] == @@cells[i+2]
    end
    for i in (0..2)
      return true if @@cells[i]==@@cells[i+3] && @@cells[i+3] == @@cells[i+6]
    end
    return true if (@@cells[0] == @@cells[4] && @@cells[4] == @@cells[8]) || (@@cells[6] == @@cells[4] && @@cells[4] == @@cells[2])

    return false
    
  end

  def restart?
    puts "Would you like to play another game? Enter 'y' or 'n':"
    response = gets.chomp.upcase
    
    if response == 'Y'
      for i in (1..9)
        @@cells[i-1] = i
      end
      @@moves = 0
      get_details
      start_game
    end
    return
  end

end

Game.new.start_game