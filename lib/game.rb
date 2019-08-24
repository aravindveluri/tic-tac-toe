require_relative "tic-tac-toe"

game = Game.new
game.get_players_details
game.play

game.screen.display_restart

while game.restart?(gets.chomp.downcase)
    game.play
    game.screen.display_restart
end