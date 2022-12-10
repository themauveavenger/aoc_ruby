class ComputerFile
  # @return [String]
  attr_accessor :name

  # @return [Integer]
  attr_accessor :size

  def initialize(name, size)
    @name = name
    @size = size
  end
end

class Directory
  # @return [String]
  attr_accessor :name

  # @return [Hash<String, Directory>]
  attr_accessor :directories

  # @return [Array<ComputerFile>]
  attr_accessor :files

  # @return [Directory]
  attr_accessor :parent

  # @param [String] name
  def initialize(name)
    @name = name
    @parent = nil
    @directories = {}
    @files = []
  end

  def add_file(name, size)
    @files.push(ComputerFile.new(name, size))
  end

  def add_directory(name, parent)
    @directories[name] = Directory.new(name)
    @directories[name].parent = parent
  end

  # @param [String] name
  # @return [Boolean]
  def directory_exists?(name)
    @directories.has_key?(name)
  end

  def file_exists?(name)
    @files.find { |f| f.name == name }
  end

  # directory size is the sum of its files + all directories it contains
  # @return [Integer]
  def size
    directory_size = @directories.map { |name, dir| dir.size }.sum
    # directory_size = @directories.map(&:size).sum
    file_size = @files.map(&:size).sum
    file_size + directory_size
  end
end

SIZE_CAP = 100_000

class Calculator
  attr_accessor :total, :sizes

  def initialize
    @total = 0
    @sizes = []
  end

  def find_size(root)
    sz = root.size
    @total += sz if sz <= SIZE_CAP

    return if root.directories.empty?

    root.directories.each_value do |d|
      find_size(d)
    end
  end

  def get_all_directory_sizes(root)
    @sizes.push(root.size)

    unless root.directories.empty?
      root.directories.each_value do |d|
        get_all_directory_sizes(d)
      end
    end
    @sizes.sort
  end
end

# @return [Directory]
def load_root
  lines = File.readlines('./2022/day07/input.txt', chomp: true)
  # lines = File.readlines('./2022/day07/testinput.txt', chomp: true)

  current_directory = Directory.new('/')
  root = current_directory

  lines.each do |line|
    # if file/dir listing, we're adding items to the current directory
    # if cd command, we're changing to the specified directory (current_directory = parent or otherwise)

    # @type [MatchData]
    dir_to_add = /dir (\w+)/.match(line) # add this dir to the cwd if it doesn't exist, when adding dir, set cwd as the parent
    current_directory.add_directory(dir_to_add[1], current_directory) if dir_to_add && dir_to_add[1]

    file_to_add = /(\d+) (\w+)/.match(line) # add this file to the cwd if it doesn't exist
    current_directory.add_file(file_to_add[2], file_to_add[1].to_i) if file_to_add && file_to_add[1] && file_to_add[2]

    change_dir = /\$ cd (.*)/.match(line) # change cwd to the specified directory
    if change_dir && change_dir[1]
      d = change_dir[1]
      if d == '..'
        current_directory = current_directory.parent unless current_directory.parent.nil?
      else
        current_directory = current_directory.directories[change_dir[1]]
      end
    end
  end
  root
end

def part_1
  root = load_root

  c = Calculator.new
  c.find_size(root)
  c.total
end

def part_2
  root = load_root

  total_size = 70_000_000
  total_used_space = root.size
  unused_space = total_size - total_used_space
  required_space = 30_000_000

  c = Calculator.new
  sizes = c.get_all_directory_sizes(root)
  diff = required_space - unused_space
  sizes.filter { |s| s >= diff }.first
end

p part_1
p part_2
