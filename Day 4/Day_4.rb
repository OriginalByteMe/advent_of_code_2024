f = File.read("day_4_input.txt")

def setup(file)
  puzzle = []
  file.each_line.with_index do |line, index|
    puzzle[index] = line.chomp
  end

  puzzle
end

puzzle = setup(f)

def get_xmas_sequence(puzzle, row, col, dx, dy, sequence_length)
  sequence = []
  sequence_length.times do |i|
    next_row = row + (dx * i)
    next_col = col + (dy * i)

    return nil if next_row < 0 || next_row >= puzzle.length()
    return nil if next_col < 0 || next_col >= puzzle[0].length()

    sequence << puzzle[next_row][next_col]
  end
  sequence.join
end

def get_x_mas_sequence(puzzle, row, col)
  # Fuck it I brutforce
  # Bruteforce proposal, given a row and column, check all 3 corners for an M and S, then check the middle for an A
  # only start the check when it notices that the row and col have landed on a `A`, then check all around them
  # Check bounds too when you check

  # Optional, see if you can do it via the diagonals

  xmas_count = 0

  if puzzle[row][col] == 'A'
    if (row >= 1 && col >= 1) && (row <= puzzle.length() - 2 && col <= puzzle[row].length() -2)
      # ↘ Diagonal:  row+1, col+1
      if (puzzle[row-1][col-1] == 'M' && puzzle[row+1][col+1] == 'S') || (puzzle[row-1][col-1] == 'S' && puzzle[row+1][col+1] == 'M')
        # ↗ Diagonal:  row-1, col+1
        if (puzzle[row-1][col+1] == 'M' && puzzle[row+1][col-1] == 'S') || (puzzle[row-1][col+1] == 'S' && puzzle[row+1][col-1] == 'M')
          xmas_count += 1
        end
      end
    end
  end
  xmas_count
end

def problem_1(puzzle)


  # Asked gpt to comment in graphics the directions, super neat!
  directions = [
    [0,1],    # → Right:     same row, col+1
    [1,0],   # ↓ Down:      row+1, same col
    [1,1],   # ↘ Diagonal:  row+1, col+1
    [1,-1],  # ↙ Diagonal:  row+1, col-1
    # Unused directions (will cause duplicates) but still looks cool so I'm keeping it here
    # [0,-1],  # ← Left:      same row, col-1
    # [-1,0],  # ↑ Up:        row-1, same col
    # [-1,1],  # ↗ Diagonal:  row-1, col+1
    # [-1,-1]  # ↖ Diagonal:  row-1, col-1
  ]

  height = puzzle.length()
  width = puzzle[0].length()
  xmas_count = 0
  height.times do |row|
    width.times do |col|
      directions.each do |dx, dy|
        sequence = get_xmas_sequence(puzzle, row, col, dx, dy, 4)
        if sequence && (sequence == "XMAS" || sequence == "SAMX")
          xmas_count += 1
        end
      end
    end
  end
  xmas_count
end

def problem_2(puzzle)

  height = puzzle.length()
  width = puzzle[0].length()
  xmas_count = 0
  height.times do |row|
    width.times do |col|
      xmas_count += get_x_mas_sequence(puzzle, row, col)
    end
  end
  xmas_count
end

puzzle_1_count = problem_1(puzzle)
p puzzle_1_count

puzzle_2_count = problem_2(puzzle)
p puzzle_2_count
