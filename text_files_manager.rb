require_relative './text_file_creator'
require_relative './block'

class TextFilesManager
  attr_reader :names

  def initialize(names: [])
    @names = names
  end

  def create_text_files
    names.each_with_index do |current_name, index|
      next_name = names[index + 1]
      text_file = TextFileCreator.new(from: current_name, to: next_name, number: index)
      text_file.create
    end
  end

  def print
    blocks_with_hash.each do |block|
      puts block.print
    end
  end

  private

  def blocks_with_hash
    (1..names.length).to_a.reverse.map do |n|
      if n > 1
        previous_content = read_file_content(n - 1)
        content = read_file_content(n)

        previous_block = Block.new(content: previous_content)
        Block.new(content: content, previous_hash: previous_block.hash)
      else
        content = read_file_content(n)
        Block.new(content: content)
      end
    end.reverse
  end

  def read_file_content number
    File.read("blocos/bloco_#{number}.txt")
  end
end
