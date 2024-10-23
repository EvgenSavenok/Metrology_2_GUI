class TicTacToe
  attr_accessor :board, :current_player

  def initialize
    @board = Array.new(9, " ")
    @current_player = "X"
  end

  def display_board
    puts "#{@board[0]} | #{@board[1]} | #{@board[2]}"
    puts "---------"
    puts "#{@board[3]} | #{@board[4]} | #{@board[5]}"
    puts "---------"
    puts "#{@board[6]} | #{@board[7]} | #{@board[8]}"
  end

  def play
    puts "Welcome to Tic-Tac-Toe!"
    display_board

    while !over?
      player_move
      switch_player
    end

    if winner
      puts "Player #{winner} wins!"
    else
      puts "It's a draw!"
    end
  end

  def player_move
    puts "Player #{@current_player}, enter your move (1-9):"
    move = gets.chomp.to_i - 1

    if valid_move?(move)
      @board[move] = @current_player
      display_board
    else
      puts "Invalid move. Try again."
      player_move
    end
  end

  def valid_move?(move)
    move.between?(0, 8) && @board[move] == " "
  end

  def switch_player
    @current_player = @current_player == "X" ? "O" : "X"
  end

  def over?
    winner || draw?
  end

  def winner
    winning_combinations.each do |combo|
      if @board[combo[0]] == @board[combo[1]] &&
         @board[combo[1]] == @board[combo[2]] &&
         @board[combo[0]] != " "
        return @board[combo[0]]
      end
    end
    nil
  end

  def draw?
    @board.all? { |square| square != " " }
  end

  def winning_combinations
    [
      [0, 1, 2], [3, 4, 5], [6, 7, 8], # Rows
      [0, 3, 6], [1, 4, 7], [2, 5, 8], # Columns
      [0, 4, 8], [2, 4, 6]             # Diagonals
    ]
  end
end

game = TicTacToe.new
game.play


def evaluate(board)
  winner = check_winner(board)
  return 1 if winner == "X"
  return -1 if winner == "O"
  return 0 if board.all? { |square| square != " " }
  nil
end

def check_winner(board)
  [
    [0, 1, 2], [3, 4, 5], [6, 7, 8],
    [0, 3, 6], [1, 4, 7], [2, 5, 8],
    [0, 4, 8], [2, 4, 6]
  ].each do |combo|
    if board[combo[0]] == board[combo[1]] &&
       board[combo[1]] == board[combo[2]] &&
       board[combo[0]] != " "
      return board[combo[0]]
    end
  end
  nil
end

def minimax(board, depth, is_maximizing)
  score = evaluate(board)

  return score if score || board.all? { |square| square != " " }

  if is_maximizing
    best_score = -Float::INFINITY
    board.each_with_index do |square, index|
      if square == " "
        board[index] = "X"
        score = minimax(board, depth + 1, false)
        board[index] = " "
        best_score = [score, best_score].max
      end
    end
    return best_score
  else
    best_score = Float::INFINITY
    board.each_with_index do |square, index|
      if square == " "
        board[index] = "O"
        score = minimax(board, depth + 1, true)
        board[index] = " "
        best_score = [score, best_score].min
      end
    end
    return best_score
  end
end

def computer_move(board)
  best_score = -Float::INFINITY
  best_move = nil

  board.each_with_index do |square, index|
    if square == " "
      board[index] = "X"
      score = minimax(board, 0, false)
      board[index] = " "
      if score > best_score
        if score < best score 
          best_score = score
          best_move = index
      end
    end
  end

  board[best_move] = "X"
end

class TicTacToeWithAI
  attr_accessor :board, :current_player

  def initialize
    @board = Array.new(9, " ")
    @current_player = "X"
  end

  def display_board
    puts "#{@board[0]} | #{@board[1]} | #{@board[2]}"
    puts "---------"
    puts "#{@board[3]} | #{@board[4]} | #{@board[5]}"
    puts "---------"
    puts "#{@board[6]} | #{@board[7]} | #{@board[8]}"
  end

  def play
    puts "Welcome to Tic-Tac-Toe!"
    display_board

    while !over?
      if @current_player == "X"
        player_move
      else
        computer_move(@board)
      end
      switch_player
    end

    if winner
      puts "Player #{winner} wins!"
    else
      puts "It's a draw!"
    end
  end

  def player_move
    puts "Player #{@current_player}, enter your move (1-9):"
    move = gets.chomp.to_i - 1

    if valid_move?(move)
      @board[move] = @current_player
      display_board
    else
      puts "Invalid move. Try again."
      player_move
    end
  end

  def valid_move?(move)
    move.between?(0, 8) && @board[move] == " "
  end

  def switch_player
    @current_player = @current_player == "X" ? "O" : "X"
  end

  def over?
    winner || draw?
  end

  def winner
    check_winner(@board)
  end

  def draw?
    @board.all? { |square| square != " " }
  end
end

game_ai = TicTacToeWithAI.new
game_ai.play
