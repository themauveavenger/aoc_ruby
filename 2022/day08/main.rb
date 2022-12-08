def part_1
  lines = File.readlines('./2022/day08/input.txt', chomp: true)
  # lines = File.readlines('./2022/day08/testinput.txt', chomp: true)
  trees = lines.map { |l| l.each_char.map(&:to_i) }
  grid_len = trees.length

  total = (grid_len * 2) + ((grid_len - 2) * 2)

  (1..trees.length - 2).each do |row|
    (1..trees.length - 2).each do |column|
      current_tree = trees[row][column]
      # up row decreases, column index stays the same
      up_visible = (0..row - 1).to_a.reverse.all? { |r| current_tree > trees[r][column] }

      # column index decreases, row stays the same
      left_visible = (0..column - 1).to_a.reverse.all? { |c| current_tree > trees[row][c] }

      # column index increases, row stays the same
      right_visible = (column + 1..grid_len - 1).to_a.all? { |c| current_tree > trees[row][c] }

      # row index increases, column stays the same
      down_visible = (row + 1..grid_len - 1).to_a.all? { |r| current_tree > trees[r][column] }

      total += 1 if up_visible || left_visible || right_visible || down_visible
    end
  end

  total
end

# @param [Integer] current
# @param [Array<Integer>] trees
# @return [Integer]
def find_tree_score(current, trees)
  ind = trees.find_index { |t| t >= current }
  if ind.nil?
    score = trees.length
  else
    score = ind + 1
  end
  score
end

def part_2
  lines = File.readlines('./2022/day08/input.txt', chomp: true)
  # lines = File.readlines('./2022/day08/testinput.txt', chomp: true)
  trees = lines.map { |l| l.each_char.map(&:to_i) }
  grid_len = trees.length

  (1..trees.length - 2).map do |row|
    (1..trees.length - 2).map do |column|
      current_tree = trees[row][column]
      # up row decreases, column index stays the same
      up_trees = (0..row - 1).to_a.reverse.map { |r| trees[r][column] }
      up_score = find_tree_score(current_tree, up_trees)

      # column index decreases, row stays the same
      left_trees = (0..column - 1).to_a.reverse.map { |c| trees[row][c] }
      left_score = find_tree_score(current_tree, left_trees)

      # column index increases, row stays the same
      right_trees = (column + 1..grid_len - 1).to_a.map { |c| trees[row][c] }
      right_score = find_tree_score(current_tree, right_trees)

      # row index increases, column stays the same
      down_trees = (row + 1..grid_len - 1).to_a.map { |r| trees[r][column] }
      down_score = find_tree_score(current_tree, down_trees)

      up_score * left_score * right_score * down_score
    end
  end.flatten.max
end

p part_1
p part_2