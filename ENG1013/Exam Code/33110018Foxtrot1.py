# Import game module
import game
# Import time module
import time
# TODO: show_board_state function to display the board for the user
def show_board_state(board, players):
    outputString = ""
    outputString = outputString + ("-" * 100) + "\n"
    for i in range(100,0,-1):
        number = i
        for j in range(len(players)):
            if players[j]["pos"] == str(i):
                number = players[j]["player"]
                number = f"({number})"
            outputString = outputString + f"| {number} "
        if i % 10 == 0:
            outputString = outputString + "|\n"
    # Your code here
    return outputString

# Main game logic
def main():
    # Setup - Add players (You can add more players here if you wish)
    game.add_player("Jon")
    game.add_player("James")
    # Check that we have enough players
    if not game.check_player_min():
        print("You need to have at least two players!")
        print("Add a player using game.add_player(\"name\") under Setup - Add players")
        return
    # Main Game loop
    while True:
        print("------------------------------------")
        # Show state of the board
        print(show_board_state(game.board, game.players))
        # Roll dice for the current player
        dice = game.roll_dice()
        # Print move of the current player
        print(f"{game.get_player_name()} rolled a {dice}!")
        # Make move for the current player on the board
        game.make_move(game.get_player(),dice,game.board)
        # Show state of the board 
        print(show_board_state(game.board, game.players))
        # Check if this player won
        print("")
        win = game.check_win(game.get_player())
        if win:
            # Current player won
            print(f"{game.get_player_name()} has won!")
            # End the game
            break
        # Next Player
        if game.currentPlayer == len(game.players)-1:
            # Set player to the first player (0) 
            game.currentPlayer = 0
        else:
            # Increment counter for next player
            game.currentPlayer+=1
        
        # Slows the game down 
        time.sleep(game.sleepTime)
main()