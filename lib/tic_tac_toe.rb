WIN_COMBINATIONS = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]


def full?(board)
    if  board.all?{|v| v == "X" || v == "O"}
        true
    else
        false 
    end       
end

def winner(board)
   x_wins = WIN_COMBINATIONS.any?{ |win|
        win.map{ |ind| ind if
          board[ind] == "X"
        } == win
        }
    o_wins = WIN_COMBINATIONS.any?{ |win|
        win.map{ |ind| ind if
          board[ind] == "O"
        } == win
        }
    if x_wins == true
        return "X"
    elsif o_wins == true
        return "O"
    else
        return nil
    end                
end

def won?(board)
    WIN_COMBINATIONS.detect{ |winner|
    board[winner[0]] == board[winner[1]] && board[winner[1]] == board[winner[2]] && board[winner[0]] != " "
  }
end 

def display_board(board)
    puts " #{board[0]} | #{board[1]} | #{board[2]} "
    puts "-----------"
    puts " #{board[3]} | #{board[4]} | #{board[5]} "
    puts "-----------"
    puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def draw?(board)
  if full?(board) == true && won?(board) == nil
    return true
  else
    return false
  end  
end

def position_taken?(board, index)
    if board[index] == "X" || board[index] == "O"
        return true
    elsif board[index] == " "  
        return false
    else
        return false
    end          
end

def valid_move?(board, index)
  if position_taken?(board, index) == false && index.between?(0,8)
    return true
  else
    return false
  end  
end

def input_to_index(input)
  a = input.to_i
  return a-1
end

def move(board, index, char)
  board[index] = char
end

def turn(board)
  puts "Where would you like to move? 1-9"
  player = current_player(board)
  input = gets.strip
  input = input_to_index(input)
  if valid_move?(board, input)
    move(board, input, player)
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
    board.map.with_index{|val, ind| position_taken?(board, ind)}.count{|x| x == true}
end    

def current_player(board)
    if turn_count(board) % 2 == 0
        return "X"
    else
        return "O"
    end        
end

def over?(board)
  if draw?(board) == true || won?(board) != nil
    return true
  end  
end

def play(board)
  turn_counter = turn_count(board)
  until turn_counter == 8 do
    turn(board)
    turn_counter = turn_count(board)
    if won?(board) == true
      puts "Congratulations #{winner(board)}!"
    elsif draw?(board) == true
      puts "Draw game. Play again?"
    else
      turn(board)
    end  
  end  
end  

play(board)