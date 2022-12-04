require 'set'

def part_1
  lines = File.readlines("./2022/day04/input.txt", chomp: true)
  # lines = %w[2-4,6-8 2-3,4-5, 2-8,3-7]
  lines.map do |line|
    first, second = line.split(",")

    range_1_start, range_1_end = first.split("-").map(&:to_i)
    range_2_start, range_2_end = second.split("-").map(&:to_i)

    range_1 = (range_1_start..range_1_end).to_a.to_set
    range_2 = (range_2_start..range_2_end).to_a.to_set

    range_1.subset?(range_2) || range_2.subset?(range_1)
  end.filter { |r| r == true }.count
end

# @return [Boolean]
def overlap(range_1, range_2)
  range_2.begin <= range_1.end && range_1.begin <= range_2.end
end

def part_2
  lines = File.readlines("./2022/day04/input.txt", chomp: true)
  lines.map do |line|
    first, second = line.split(",")

    range_1_start, range_1_end = first.split("-").map(&:to_i)
    range_2_start, range_2_end = second.split("-").map(&:to_i)

    range_1 = (range_1_start..range_1_end)
    range_2 = (range_2_start..range_2_end)

    overlap(range_1, range_2)
  end.filter { |r| r == true }.count
end

p part_1
p part_2