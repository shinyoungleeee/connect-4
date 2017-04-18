require 'pry'

class Grid
  attr_reader :grid

  def initialize
    @grid = [
      [nil, nil, nil, nil, nil, nil, nil],
      [nil, nil, nil, nil, nil, nil, nil],
      [nil, nil, nil, nil, nil, nil, nil],
      [nil, nil, nil, nil, nil, nil, nil],
      [nil, nil, nil, nil, nil, nil, nil],
      [nil, nil, nil, nil, nil, nil, nil],
      ["^", "^", "^", "^", "^", "^", "^"],
      ["A", "B", "C", "D", "E", "F", "G"]
    ]
  end

  def drop(column = nil, player = nil)
    if column.nil? || player.nil?
      puts "Invalid entry."
      return false
    end

    column.upcase!
    player.upcase!

    if ["A", "B", "C", "D", "E", "F", "G"].find_index(column).nil?
      puts "Please enter a single letter between A-G."
      return false
    elsif ["X", "O"].find_index(player).nil?
      puts "Player piece must be X or O."
      return false
    end

    column_number = ["A", "B", "C", "D", "E", "F", "G"].find_index(column)

    if !@grid[0][column_number].nil?
      puts "This column is full. Please enter another."
      return false
    end

    @grid.reverse_each do |row|
      if row[column_number].nil?
        row[column_number] = player
        break
      end
    end

    puts "Success."
    return true
  end

  def show
    visual_grid = []
    @grid.each do |row|
      this_row = []
      row.each do |column|
        this_column = column
        if column.nil?
          this_column = "-"
        end

        this_column = "| " + this_column + " "
        this_row << this_column
      end
      this_row[-1] = this_row[-1] + "|"
      visual_grid << this_row
    end

    visual_grid.map { |row| row.join('') }
  end

  def check(player)
    row = 5
    while row >= 0
      column = 0
      while column < 7
        if @grid[row][column] == player
          # Horizontal check
          right_1 = (@grid[row][column + 1] == player)
          right_2 = (@grid[row][column + 2] == player)
          right_3 = (@grid[row][column + 3] == player)
          if right_1 && right_2 && right_3
            return true
          end

          # Vertical Check
          if row - 3 >= 0
            up_1 = (@grid[row - 1][column] == player)
            up_2 = (@grid[row - 2][column] == player)
            up_3 = (@grid[row - 3][column] == player)
          end
          if up_1 && up_2 && up_3
            return true
          end

          # Forward Slash Check \
          if row + 3 < 6
            down_and_right_1 = (@grid[row + 1][column + 1] == player)
            down_and_right_2 = (@grid[row + 2][column + 2] == player)
            down_and_right_3 = (@grid[row + 3][column + 3] == player)
          end
          if down_and_right_1 && down_and_right_2 && down_and_right_3
            return true
          end

          # Backward Slash Check /
          if row - 3 >= 0
            up_and_right_1 = (@grid[row - 1][column + 1] == player)
            up_and_right_2 = (@grid[row - 2][column + 2] == player)
            up_and_right_3 = (@grid[row - 3][column + 3] == player)
          end
          if up_and_right_1 && up_and_right_2 && up_and_right_3
            return true
          end
        end
        column += 1
      end
      row -= 1
    end

    false
  end

  def game_over
    game_over = @grid.any? do |row|
      row.any? do |column|
        column.nil?
      end
    end

    if !game_over
      puts "No spaces remaining."
      return true
    end
  end
end
