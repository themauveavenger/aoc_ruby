def part_1
  # A = ROCK
  # B = PAPER
  # C = SCISSORS
  # X = ROCK (1)
  # Y = PAPER (2)
  # Z = SCISSORS (3)
  # WIN = 6
  # DRAW = 3
  # LOSS = 0
  match_ups = {
    'AX' => 4, # ROCK ROCK DRAW
    'AY' => 8, # ROCK PAPER I WIN
    'AZ' => 3, # ROCK SCISSORS I LOSE
    'BX' => 1, # PAPER ROCK I LOSE
    'BY' => 5, # PAPER PAPER DRAW
    'BZ' => 9, # PAPER SCISSORS I WIN
    'CX' => 7, # SCISSORS ROCK I WIN
    'CY' => 2, # SCISSORS PAPER I LOSE
    'CZ' => 6 # SCISSORS SCISSORS DRAW
  }

  lines = File.readlines('./2022/day02/input.txt', chomp: true)

  lines.map do |line|
    strategy = line.gsub(/\s/, '')
    match_ups[strategy]
  end.sum
end

def part_2
  # A = ROCK
  # B = PAPER
  # C = SCISSORS
  # WIN = 6
  # DRAW = 3
  # LOSS = 0
  # X = LOSE
  # Y = DRAW
  # Z = WIN
  # ROCK (1)
  # PAPER (2)
  # SCISSORS (3)
  match_ups = {
    'AX' => 3, # LOSE ROCK SCISSORS
    'AY' => 4, # DRAW ROCK ROCK
    'AZ' => 8, # WIN ROCK PAPER
    'BX' => 1, # LOSE PAPER ROCK
    'BY' => 5, # DRAW PAPER PAPER
    'BZ' => 9, # WIN PAPER SCISSORS
    'CX' => 2, # LOSE SCISSORS PAPER
    'CY' => 6, # DRAW SCISSORS SCISSORS
    'CZ' => 7  # WIN SCISSORS ROCK
  }

  lines = File.readlines('./2022/day02/input.txt', chomp: true)

  lines.map do |line|
    strategy = line.gsub(/\s/, '')
    match_ups[strategy]
  end.sum

end

p part_1
p part_2