require "./lib/tic-tac-toe"

describe Game do
    subject(:gm) {Game.new}

    describe "players name and type" do
        it "gets correct name input" do
            gm.player_1.name = "Kaneki"
            gm.player_2.name = "Touka"
            expect(gm.player_1.name).to eq("Kaneki")
            expect(gm.player_2.name).to eq("Touka")
        end
        it "gets correct type" do
            gm.player_1.type = "X"
            gm.player_2.type = "O"
            expect(gm.player_1.type).to eq("X")
            expect(gm.player_2.type).to eq("O")
        end
    end

    describe "Update cell" do
        it "changes value in cell to given mark" do
            gm.operations.update_cell(1, "X", gm.board)
            expect(gm.board.cells).to eql(["X", 2, 3, 4, 5, 6, 7, 8, 9])
        end
    end

    describe "Player 1 win scenarios" do
        it "vertical win column 1 player 1" do
            gm.player_1.type = "X"
            gm.board.cells[0] = "X"
            gm.board.cells[3] = "X"
            gm.board.cells[6] = "X"
            gm.set_winner
            expect(gm.winner).to eq(gm.player_1)
        end
        it "vertical win column 2 player 1" do
            gm.player_1.type = "X"
            gm.board.cells[1] = "X"
            gm.board.cells[4] = "X"
            gm.board.cells[7] = "X"
            gm.set_winner
            expect(gm.winner).to eq(gm.player_1)
        end
        it "vertical win column 3 player 1" do
            gm.player_1.type = "X"
            gm.board.cells[2] = "X"
            gm.board.cells[5] = "X"
            gm.board.cells[8] = "X"
            gm.set_winner
            expect(gm.winner).to eq(gm.player_1)
        end
        it "horizontal win row 1 player 1" do
            gm.player_1.type = "X"
            gm.board.cells[0] = "X"
            gm.board.cells[1] = "X"
            gm.board.cells[2] = "X"
            gm.set_winner
            expect(gm.winner).to eq(gm.player_1)
        end
        it "horizontal win row 2 player 1" do
            gm.player_1.type = "X"
            gm.board.cells[3] = "X"
            gm.board.cells[4] = "X"
            gm.board.cells[5] = "X"
            gm.set_winner
            expect(gm.winner).to eq(gm.player_1)
        end
        it "horizontal win row 3 player 1" do
            gm.player_1.type = "X"
            gm.board.cells[6] = "X"
            gm.board.cells[7] = "X"
            gm.board.cells[8] = "X"
            gm.set_winner
            expect(gm.winner).to eq(gm.player_1)
        end
        it "top-down win diagonal player 1" do
            gm.player_1.type = "X"
            gm.board.cells[0] = "X"
            gm.board.cells[4] = "X"
            gm.board.cells[8] = "X"
            gm.set_winner
            expect(gm.winner).to eq(gm.player_1)
        end
        it "bottom-up win diagonal player 1" do
            gm.player_1.type = "X"
            gm.board.cells[6] = "X"
            gm.board.cells[4] = "X"
            gm.board.cells[2] = "X"
            gm.set_winner
            expect(gm.winner).to eq(gm.player_1)
        end
    end

    describe "Player 2 win scenarios" do
        it "vertical win column 1 player 2" do
            gm.player_2.type = "O"
            gm.board.cells[0] = "O"
            gm.board.cells[3] = "O"
            gm.board.cells[6] = "O"
            gm.set_winner
            expect(gm.winner).to eq(gm.player_2)
        end
        it "vertical win column 2 player 2" do
            gm.player_2.type = "O"
            gm.board.cells[1] = "O"
            gm.board.cells[4] = "O"
            gm.board.cells[7] = "O"
            gm.set_winner
            expect(gm.winner).to eq(gm.player_2)
        end
        it "vertical win column 3 player 2" do
            gm.player_2.type = "O"
            gm.board.cells[2] = "O"
            gm.board.cells[5] = "O"
            gm.board.cells[8] = "O"
            gm.set_winner
            expect(gm.winner).to eq(gm.player_2)
        end
        it "horizontal win row 1 player 2" do
            gm.player_2.type = "O"
            gm.board.cells[0] = "O"
            gm.board.cells[1] = "O"
            gm.board.cells[2] = "O"
            gm.set_winner
            expect(gm.winner).to eq(gm.player_2)
        end
        it "horizontal win row 2 player 2" do
            gm.player_2.type = "O"
            gm.board.cells[3] = "O"
            gm.board.cells[4] = "O"
            gm.board.cells[5] = "O"
            gm.set_winner
            expect(gm.winner).to eq(gm.player_2)
        end
        it "horizontal win row 3 player 2" do
            gm.player_2.type = "O"
            gm.board.cells[6] = "O"
            gm.board.cells[7] = "O"
            gm.board.cells[8] = "O"
            gm.set_winner
            expect(gm.winner).to eq(gm.player_2)
        end
        it "top-down win diagonal player 2" do
            gm.player_2.type = "O"
            gm.board.cells[0] = "O"
            gm.board.cells[4] = "O"
            gm.board.cells[8] = "O"
            gm.set_winner
            expect(gm.winner).to eq(gm.player_2)
        end
        it "bottom-up win diagonal player 2" do
            gm.player_2.type = "O"
            gm.board.cells[6] = "O"
            gm.board.cells[4] = "O"
            gm.board.cells[2] = "O"
            gm.set_winner
            expect(gm.winner).to eq(gm.player_2)
        end
    end
    
    describe "Draw" do
        it "is draw by moves" do
            gm.player_1.type = "X"
            gm.player_2.type = "O"

            gm.operations.moves = 9
            expect(gm.operations.game_over?(gm.player_1, gm.player_2, gm.board)).to eq(true)
        end
    end
    
    describe "Restart" do
        it "resets the gameboard" do
            gm.restart?("y")
            expect(gm.board.cells).to eql([1, 2, 3, 4, 5, 6, 7, 8, 9])
            expect(gm.operations.moves).to eql(0)
        end
    end
end