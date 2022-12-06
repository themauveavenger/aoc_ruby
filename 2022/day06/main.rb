require 'set'

def part_1
  input = File.read('./2022/day06/input.txt')
  # inputs = %w[mjqjpqmgbljsphdztnvjfqwrcgsmlb bvwbjplbgvbhsrlpgdmjqwftvncz nppdvjthqldpwncqszvftbrmjlhg zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw]

  input.chars.each_cons(4) do |window|
    if window.to_set.length == window.length
      # all are unique
      p window
      p input.index(window.join) + window.length
      break
    end
  end
end

def part_2
  input = File.read('./2022/day06/input.txt')
  # inputs = %w[mjqjpqmgbljsphdztnvjfqwrcgsmlb bvwbjplbgvbhsrlpgdmjqwftvncz nppdvjthqldpwncqszvftbrmjlhg zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw]

  input.chars.each_cons(14) do |window|
    if window.to_set.length == window.length
      # all are unique
      p window
      p input.index(window.join) + window.length
      break
    end
  end
end

part_1
part_2