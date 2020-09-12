class TextFileCreator
  attr_reader :from, :to, :number

  def initialize(from:, to:, number:)
    @from = from
    @to = to
    @number = number
  end

  def content
    <<~HEREDOC
    Origem: #{from}
    Destino: #{to}
    Mensagem: Ola #{to}. Meu nome é #{from}.
    HEREDOC
  end

  def create
    text_file = File.new("blocos/bloco_#{number}.txt", "w")
    text_file.puts(content)
    text_file.close
  end
end
