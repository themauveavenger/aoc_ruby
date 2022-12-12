# frozen_string_literal: true

class Item
  attr_accessor :worry_level

  def initialize(level)
    @worry_level = level
  end
end

class Monkey
  # @type [Array<Item>]
  attr_accessor :items

  # @type [Array]
  attr_accessor :test_divisor

  attr_accessor :operation, :inspect_count, :common_divisor

  def initialize(levels, operation, divisor, true_monkey, false_monkey)
    @items = levels.map { |l| Item.new(l) }
    @operation = operation
    @test_divisor = divisor
    @true_monkey = true_monkey
    @false_monkey = false_monkey
    @inspect_count = 0
  end

  def get_target_monkey(level)
    (level % @test_divisor).zero? ? @true_monkey : @false_monkey
  end

  def increment
    @inspect_count += 1
  end

  # returns a list of worry levels & their target monkeys
  def do_turn
    targets = []
    until @items.empty?
      item = @items.shift
      # @type [Integer]
      new_worry_level = @operation.call(item.worry_level)

      increment

      # new_worry_level = (new_worry_level / 3).floor
      item.worry_level = new_worry_level % @common_divisor

      target_monkey = get_target_monkey(item.worry_level)
      targets.push([target_monkey, item])
    end

    targets
  end
end

def part_1
  # monkeys = {
  #   0 => Monkey.new([79, 98], ->(l) { l * 19 }, 23, 2, 3),
  #   1 => Monkey.new([54, 65, 75, 74], ->(l) { l + 6 }, 19, 2, 0 ),
  #   2 => Monkey.new([79, 60, 97], ->(l) { l * l }, 13, 1, 3),
  #   3 => Monkey.new([74], ->(l) { l + 3 }, 17, 0, 1)
  # }
  monkeys = {
    0 => Monkey.new([56, 56, 92, 65, 71, 61, 79], ->(l) { l * 7 }, 3, 3, 7),
    1 => Monkey.new([61, 85], ->(l) { l + 5 }, 11, 6, 4),
    2 => Monkey.new([54, 96, 82, 78, 69], ->(l) { l * l }, 7, 0, 7),
    3 => Monkey.new([57, 59, 65, 95], ->(l) { l + 4 }, 2, 5, 1),
    4 => Monkey.new([62, 67, 80], ->(l) { l * 17 }, 19, 2, 6),
    5 => Monkey.new([91], ->(l) { l + 7 }, 5, 1, 4),
    6 => Monkey.new([79, 83, 64, 52, 77, 56, 63, 92], ->(l) { l + 6 }, 17, 2, 0),
    7 => Monkey.new([50, 97, 76, 96, 80, 56], ->(l) { l + 3 }, 13, 3, 5),
  }

  rounds = 20

  rounds.times do
    monkeys.each_value do |monkey|
      targets = monkey.do_turn
      targets.each do |target|
        monkeys[target[0]].items.push(target[1])
      end
    end
  end
  monkeys.values.map(&:inspect_count).max(2).inject(&:*)
end

def part_2
  # monkeys = {
  #   0 => Monkey.new([79, 98], ->(l) { l * 19 }, 23, 2, 3),
  #   1 => Monkey.new([54, 65, 75, 74], ->(l) { l + 6 }, 19, 2, 0 ),
  #   2 => Monkey.new([79, 60, 97], ->(l) { l * l }, 13, 1, 3),
  #   3 => Monkey.new([74], ->(l) { l + 3 }, 17, 0, 1)
  # }
  monkeys = {
    0 => Monkey.new([56, 56, 92, 65, 71, 61, 79], ->(l) { l * 7 }, 3, 3, 7),
    1 => Monkey.new([61, 85], ->(l) { l + 5 }, 11, 6, 4),
    2 => Monkey.new([54, 96, 82, 78, 69], ->(l) { l * l }, 7, 0, 7),
    3 => Monkey.new([57, 59, 65, 95], ->(l) { l + 4 }, 2, 5, 1),
    4 => Monkey.new([62, 67, 80], ->(l) { l * 17 }, 19, 2, 6),
    5 => Monkey.new([91], ->(l) { l + 7 }, 5, 1, 4),
    6 => Monkey.new([79, 83, 64, 52, 77, 56, 63, 92], ->(l) { l + 6 }, 17, 2, 0),
    7 => Monkey.new([50, 97, 76, 96, 80, 56], ->(l) { l + 3 }, 13, 3, 5)
  }

  rounds = 10_000

  common_divisor = monkeys.values.map(&:test_divisor).inject(:*)
  p common_divisor
  monkeys.each_value { |m| m.common_divisor = common_divisor }

  rounds.times do
    monkeys.each_value do |monkey|
      targets = monkey.do_turn
      targets.each do |target|
        monkeys[target[0]].items.push(target[1])
      end
    end
  end

  p monkeys.values.map(&:inspect_count)
  monkeys.values.map(&:inspect_count).max(2).inject(&:*)
end

# p part_1
p part_2
