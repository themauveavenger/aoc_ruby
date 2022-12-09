# frozen_string_literal: true

require 'set'
require 'matrix'

# @param [String] direction
# @return [Vector]
def get_vector_direction(direction)
  case direction
  when 'D'
    vector_dir = Vector[0, -1]
  when 'U'
    vector_dir = Vector[0, 1]
  when 'L'
    vector_dir = Vector[-1, 0]
  when 'R'
    vector_dir = Vector[1, 0]
  else
    raise 'Bad Direction'
  end
  vector_dir
end

def part_1
  lines = File.readlines('./2022/day09/input.txt', chomp: true)

  tail_points = Set.new

  head = Vector[0, 0]
  tail = Vector[0, 0]

  tail_points.add(tail.to_s)

  lines.each do |line|
    direction, count = line.split(/\s/)
    count = count.to_i

    vector_dir = get_vector_direction(direction)

    count.times do
      head += vector_dir

      diff = (head - tail)

      next unless diff.magnitude >= 2

      normalized = diff.map { |x| x.zero? ? 0 : x / x.abs }
      tail += normalized
      tail_points.add(tail.to_s)
    end
  end

  tail_points.length
end

def part_2
  lines = File.readlines('./2022/day09/input.txt', chomp: true)

  tail_points = Set.new

  knots = Array.new(10, Vector[0, 0])

  tail_points.add(knots.last.to_s)

  lines.each do |line|
    direction, count = line.split(/\s/)
    count = count.to_i

    vector_dir = get_vector_direction(direction)

    count.times do
      # move head first, everything else follows
      knots[0] += vector_dir
      (0..knots.length - 1).each_cons(2) do |subset|
        head_index, tail_index = subset
        diff = (knots[head_index] - knots[tail_index])

        next unless diff.magnitude >= 2

        normalized = diff.map { |x| x.zero? ? 0 : x / x.abs }
        knots[tail_index] += normalized
        tail_points.add(knots.last.to_s)
      end
    end
  end

  tail_points.length
end

p part_1
p part_2
