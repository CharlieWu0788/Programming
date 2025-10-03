def print_board(ttt_board):
    print(' ')
    print('==    Current State     ==')
    for row in ttt_board:
        row_text = '          '
        for value in row:
            row_text += value + ' '
        print(row_text)

def check_winner(ttt_board):
    for row in ttt_board:
        if row.count('X') == 3:
            print('####   Player 1 Wins  ####')
            return 'X'
        elif row.count('O') == 3:
            print('####   Player 2 Wins  ####')
            return 'O'
        
def check_columns(ttt_board):
    for col in range(3):
        column = [ttt_board[0][col], ttt_board[1][col], ttt_board[2][col]]
        if column.count('X') == 3:
            print('####   Player 1 Wins  ####')
            return 'X'
        elif column.count('O') == 3:
            print('####   Player 2 Wins  ####')
            return 'O'

def check_diagonals(ttt_board):
    diagnal_1 = [ttt_board[0][0], ttt_board[1][1], ttt_board[2][2]]
    diagnal_2 = [ttt_board[0][2], ttt_board[1][1], ttt_board[2][0]]
    if diagnal_1.count('X') == 3 or diagnal_2.count('X') == 3:
        print('####   Player 1 Wins  ####')
        return 'X'
    elif diagnal_1.count('O') == 3 or diagnal_2.count('O') == 3:
        print('####   Player 2 Wins  ####')
        return 'O'
    return None

def main():
    ttt_board = [['-' for _ in range(3)] for _ in range(3)]
    print_board(ttt_board)
    current_player = 'X'
    for turn in range(9):
        print(f"Player {'1' if current_player == 'X' else '2'}'s turn ({current_player})")
        while True:
            try:
                row = int(input('Which row do you want to play at? (1-3) '))
                col = int(input('Which column do you want to play at? (1-3) '))
                if 1 <= row <= 3 and 1 <= col <= 3 and ttt_board[row-1][col-1] == '-':
                    ttt_board[row-1][col-1] = current_player
                    break
                else:
                    print('Invalid input or space already occupied, please select another one')
            except ValueError:
                print('Please enter valid integers for row and column.')
        print_board(ttt_board)
        winner = check_winner(ttt_board)
        if winner:
            return
        current_player = 'O' if current_player == 'X' else 'X'
    print('####   Draw!   ####')

if __name__ == "__main__":
    main()