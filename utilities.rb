module Utilities
  # reads a file by line into collection
  # @param [String] filepath
  # @return [Array<String>]
  def read_file(filepath)
    File.readlines(filepath, chomp: true)
  end
end
