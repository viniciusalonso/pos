require 'digest'

class Block
  attr_reader :content, :previous_hash

  def initialize(content:, previous_hash: 'Vazio')
    @content = content
    @previous_hash = previous_hash
  end

  def hash
    Digest::SHA256.hexdigest content
  end

  def print
    <<~HEREDOC

    #{content}
    Hash: #{hash}
    Hash Anterior: #{previous_hash}
    HEREDOC
  end
end
