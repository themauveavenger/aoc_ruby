# frozen_string_literal: true

def part_1
  lines = File.readlines('./2022/day01/input.txt', chomp: true)

  total = 0
  max = 0
  lines.each do |line|
    if line == ''
      max = total if max < total
      total = 0
    else
      total += line.to_i
    end
  end

  max
end

def part_2
  lines = File.readlines('./2022/day01/input.txt', chomp: true)

  # @type [Array<Integer>]
  totals = []

  total = 0
  lines.each do |line|
    if line == ''
      totals.push(total)
      total = 0
    else
      total += line.to_i
    end
  end

  totals.sort { |a, b| b <=> a }.take(3).sum
end

p part_1
p part_2