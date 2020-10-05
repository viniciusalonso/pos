require_relative '../block'

module TextFile
  class Reader
    def blocks_with_hash(names)
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

    private

    def read_file_content number
      File.read("blocos/bloco_#{number}.txt")
    end
  end
end
