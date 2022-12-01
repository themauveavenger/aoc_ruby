# frozen_string_literal: true

# @return [Array<Integer>]
def totals
  all_elves = File.read("./2022/day01/input.txt").split("\n\n")

  all_elves.map do |elf|
    elf.split("\n").map(&:to_i).sum
  end
end
def part_1
  totals.max
end

def part_2
  totals.max(3).sum
end

p part_1
p part_2