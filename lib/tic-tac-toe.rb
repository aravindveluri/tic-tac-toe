class Player
  attr_accessor :name, :type

  def initialize
  end

  def validate_type(input)
    input = input.upcase

    until input == "X" || input == "O"
      puts "Enter either 'x' or 'o'"
      input = gets.chomp.upcase
    end

    return input
  end

  def get_details(playerNum)

    puts "Enter your name, player #{playerNum}:"
    @name = gets.chomp
    if playerNum == 1
      puts "Which one do you want to play as? 'X' or 'O'?"
      @type = validate_type(gets.chomp) 
    end

  end

  def won?(gameboard)
    cells = gameboard.cells
    for i in (0..2)
      i += i*2
      return true if cells[i]==@type && cells[i+1] == @type && cells[i+2] == @type
    end

    for i in (0..2)
      return true if cells[i]==@type && cells[i+3] == @type && cells[i+6] == @type
    end

    return true if (cells[0] == @type && cells[4] == @type && cells[8] == @type) ||
     (cells[6] == @type && cells[4] == @type && cells[2] == @type)

    return false
  
  end

end

class GameBoard
  
  attr_accessor :cells

  def initialize
    @cells = (1..9).to_a
  end

  def reset
    for i in (1..9)
      @cells[i-1] = i
    end
  end

end

class Screen
  
  def initialize
  end

  def display_guide
    puts "#######################################"
    puts "### Welcome To My Tic-Tac-Toe Game! ###"
    puts "#######################################"
    puts "_______________________________________"
    puts nil
    puts "################ RULES ################"
    puts "Two players will take turns to mark the"
    puts " spaces on a 3x3 grid. The player who  "
    puts " succeeds in placing 3 of their marks  "
    puts "horizontally, vertically, or diagonally"
    puts " wins the game. When there are no more "
    puts "spaces left to mark, it is considered a"
    puts "draw. To place a mark on the grid, type"
    puts "the number on the space you would like "
    puts "to mark, as shown below! Good luck! \n "
  end
  
  def display_grid(gameboard)
    print "| ", gameboard.cells[0], " | ", gameboard.cells[1], " | ", gameboard.cells[2], " | ", "\n"
    puts "----+---+----"
    print "| ", gameboard.cells[3], " | ", gameboard.cells[4], " | ", gameboard.cells[5], " | ", "\n"
    puts "----+---+----"
    print "| ", gameboard.cells[6], " | ", gameboard.cells[7], " | ", gameboard.cells[8], " | ", "\n"
  end

  def display_winner(winner)
    puts "#{winner.name} won the game!!"
  end

  def display_restart
    puts "Would you like to play another game?"
  end
  

end

class GameFunctionality
  
  attr_accessor :moves

  def initialize
    @moves = 0
  end

  def get_valid_cell(gameboard)
    cell = gets.chomp
    begin
      raise if !(gameboard.cells.include?(Integer cell))  
    rescue
      puts "Please enter an available box as a number"
      cell = gets.chomp
      retry
    end
    return Integer cell
  end

  def update_cell(cell_number, mark, gameboard)
    gameboard.cells[cell_number - 1] = mark
  end

  def play_round(player, gameboard)
    puts "It's #{player.name}'s turn!"
    update_cell(get_valid_cell(gameboard), player.type, gameboard)
    @moves += 1
  end

  def game_over?(player_1, player_2, gameboard)
    (win?(player_1, player_2, gameboard) || @moves == 9)
  end

  def win?(player_1, player_2, gameboard)
    return player_1.won?(gameboard) || player_2.won?(gameboard)
  end

  def reset
    @moves = 0
  end

end

class Game

  attr_accessor :player_1, :player_2, :winner, :board, :operations, :screen

  def initialize
    @winner = nil
    @board = GameBoard.new
    @player_1 = Player.new
    @player_2 = Player.new
    @operations = GameFunctionality.new
    @screen = Screen.new

  end

  def get_players_details
    @player_1.get_details 1
    @player_2.get_details 2
    @player_1.type == "X" ? @player_2.type = "O" : @player_2.type = "X"  
  end

  def set_winner
    if @player_1.won? @board
      @winner = @player_1
      return true
    elsif @player_2.won? @board
      @winner = @player_2
      return true
    else
      return false
    end
  end

  def play
    @screen.display_guide
    
    current_player = @player_1
    
    while !@operations.game_over?(@player_1, @player_2, @board)
      @screen.display_grid @board
      @operations.play_round current_player, @board
      current_player == @player_1 ? current_player = @player_2 : current_player = @player_1
    end

    if set_winner
        @screen.display_grid @board
        @screen.display_winner @winner
    else
      @screen.display_grid @board
      puts "it's a Draw!!"
    end


  end

  def restart?(response)
    
    if response == 'y'

      @board.reset
      @operations.reset
      return true
    end

    return false
  
  end
end
