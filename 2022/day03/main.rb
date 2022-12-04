class String
  def upper?
    self == self.upcase
  end

  def lower?
    self == self.downcase
  end

  def priority
    if self.lower?
      self.ord - 96
    else
      self.ord - 38
    end
  end
end

def part_1
  lines = File.readlines('./2022/day03/input.txt', chomp: true)
  # lines = %w[vJrwpWtwJgWrhcsFMMfFFhFp jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL PmmdzqPrVvPwwTWBwg wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn ttgJtRGJQctTZtZT CrZsJsPPZsGzwwsLwLmpwMDw]
  lines.map do |line|
    middle_index = (line.length - 1) / 2

    one = line[0..middle_index]
    two = line[(middle_index + 1)..-1]

    common_char = (one.chars & two.chars).first

    common_char.priority
  end.sum
end

def part_2
  lines = File.readlines('./2022/day03/input.txt', chomp: true)
  # lines = %w[vJrwpWtwJgWrhcsFMMfFFhFp jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL PmmdzqPrVvPwwTWBwg wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn ttgJtRGJQctTZtZT CrZsJsPPZsGzwwsLwLmpwMDw]

  total = 0
  lines.each_slice(3) do |group|
    one, two, three = group

    common_char = (one.chars & two.chars & three.chars).first

    total += common_char.priority
  end
  total
end

p part_1
p part_2