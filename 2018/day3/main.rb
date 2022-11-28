# frozen_string_literal: true

# a claim
class Claim
  attr_accessor :id, :width, :height, :x, :y, :overlap

  # #123 @ 3,2: 5x4
  # @param [String] line
  def initialize(line)
    @id = line.match(/#\d+/)[0].delete_prefix('#')
    w, h = line.match(/\d+x\d+/i)[0].split('x')
    @width = w.to_i
    @height = h.to_i
    x, y = line.match(/\d+,\d+/i)[0].split(',')
    @x = x.to_i
    @y = y.to_i
  end

  def end_pos_x
    @x + @width - 1
  end

  def end_pos_y
    @y + @height - 1
  end
end

def part1
  lines = File.readlines('./2018/day3/input.txt', chomp: true)

  claims = lines.map do |line|
    Claim.new(line)
  end

  fabric = Array.new(1000, 0) { Array.new(1000, 0) }

  claims.each do |claim|
    (claim.x..claim.end_pos_x).to_a.each do |x|
      (claim.y..claim.end_pos_y).to_a.each do |y|
        fabric[x][y] += 1
      end
    end
  end

  total = 0
  fabric.each do |row|
    row.each do |value|
      total += 1 if value >= 2
    end
  end

  p total
end

def part2
  lines = File.readlines('./2018/day3/input.txt', chomp: true)

  # @type [Hash{String=>Claim}]
  claims = {}
  lines.each do |line|
    c = Claim.new(line)
    claims.store(c.id, c)
  end

  fabric = Array.new(1000, nil) { Array.new(1000, nil) }

  claims.each do |id, claim|
    (claim.x..claim.end_pos_x).to_a.each do |x|
      (claim.y..claim.end_pos_y).to_a.each do |y|
        fabric_val = fabric[x][y]
        if fabric_val
          claims[fabric_val].overlap = true
          claim.overlap = true
        end
        fabric[x][y] = claim.id
      end
    end
  end

  p claims.values.filter {|c| c.overlap.nil? }
end

p part1
p part2