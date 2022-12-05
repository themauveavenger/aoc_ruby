

def part_1
  stacks = [
    'BZT'.chars,
    'VHTDN'.chars,
    'BFMD'.chars,
    'TJGWVQL'.chars,
    'WDGPVFQM'.chars,
    'VZQGHFS'.chars,
    'ZSNRLTCW'.chars,
    'ZHWDJNRM'.chars,
    'MQLFDS'.chars
  ]

  lines = File.readlines('./2022/day05/input.txt', chomp: true)

  lines.each do |line|
    instruction = /move (\d+) from (\d+) to (\d+)/.match(line)

    # @type [Integer]
    number_of_crates = instruction[1].to_i

    # stacks instruction start at 1
    from_stack = instruction[2].to_i - 1
    to_stack = instruction[3].to_i - 1

    number_of_crates.times do
      crate = stacks[from_stack].pop
      stacks[to_stack].push(crate)
    end
  end

  result = stacks.map { |s| s.pop }
  result.join
end

def part_2
  stacks = [
    'BZT'.chars,
    'VHTDN'.chars,
    'BFMD'.chars,
    'TJGWVQL'.chars,
    'WDGPVFQM'.chars,
    'VZQGHFS'.chars,
    'ZSNRLTCW'.chars,
    'ZHWDJNRM'.chars,
    'MQLFDS'.chars
  ]

  lines = File.readlines('./2022/day05/input.txt', chomp: true)

  lines.each do |line|
    instruction = /move (\d+) from (\d+) to (\d+)/.match(line)

    # @type [Integer]
    number_of_crates = instruction[1].to_i

    # stacks instruction start at 1
    from_stack = instruction[2].to_i - 1
    to_stack = instruction[3].to_i - 1

    crates = stacks[from_stack].pop(number_of_crates)
    stacks[to_stack] = stacks[to_stack] + crates
  end

  result = stacks.map { |s| s.pop }
  result.join
end

p part_1
p part_2