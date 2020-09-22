require_relative './text_file'

class TextFilesManager
  attr_reader :names

  def initialize(names: [])
    @names = names
  end

  def create_text_files
    names.each.with_index(1) do |current_name, index|
      next_name = names[index + 1]
      text_file = TextFile::Writer.new(from: current_name, to: next_name, number: index)
      text_file.create
    end
  end

  def print_text_files
    reader = TextFile::Reader.new
    reader.blocks_with_hash(names).each do |block|
      puts block.print
    end
  end
end
