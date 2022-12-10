def part_1
  lines = File.readlines('./2022/day10/input.txt', chomp: true)
  # lines = ['noop', 'addx 3', 'addx -5']

  interesting_cyles = [20, 60, 100, 140, 180, 220]

  x_register = 1

  add_queue = []

  strengths = []

  total_cycles = lines.map do |line|
    line.start_with?('addx') ? 2 : 1
  end.sum

  total_cycles.times do |index|
    # don't pull an instruction off until the add queue is clear
    cycle = index + 1
    instruction = nil
    if add_queue.empty?
      line = lines.shift if add_queue.empty?
      instruction, amount = line.split(/\s/) unless line.nil?
      amount = amount.to_i unless amount.nil?
    end

    if instruction == 'addx'
      # determine the cycle this instruction will update x register on
      add_queue += [0, amount]
    end

    strengths.push(cycle * x_register) if interesting_cyles.include?(cycle)

    # as the cycle ends, update x register
    x_register += add_queue.shift unless add_queue.empty?
  end

  p strengths
  strengths.sum
end

def part_2
  lines = File.readlines('./2022/day10/input.txt', chomp: true)
  x_register = 1
  add_queue = []

  total_cycles = lines.map do |line|
    line.start_with?('addx') ? 2 : 1
  end.sum

  crt = Array.new(total_cycles)

  total_cycles.times do |index|
    instruction = nil
    if add_queue.empty?
      line = lines.shift if add_queue.empty?
      instruction, amount = line.split(/\s/) unless line.nil?
      amount = amount.to_i unless amount.nil?
    end

    if instruction == 'addx'
      # determine the cycle this instruction will update x register on
      add_queue += [0, amount]
    end

    # draw
    # is sprite position on the index?
    position = index % 40
    c = '.'
    c = '#' if position.between?(x_register - 1, x_register + 1)
    crt[index] = c

    x_register += add_queue.shift unless add_queue.empty?
  end

  crt.each_slice(40) do |crt_line|
    p crt_line.join
  end

end

p part_1
part_2 # EGJBGCFK
