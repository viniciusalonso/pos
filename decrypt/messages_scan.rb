require_relative './message_decryptor'

class MessagesScan
  attr_reader :names

  def initialize(names: [])
    @names = names
  end

  def scan_all_messages
    names.each do |name|
      encrypted_messages.each do |filename|
        begin
          encrypted_content = File.read(filename)
          decryptor = MessageDecryptor.new(raw_content_key: plain_text_private_key(name))
          content = decryptor.decrypt(encrypted_content)

          filename.slice!('files/inputs/')
          File.open("files/outputs/#{filename}", "w+") do |f|
            f.write content
          end
        rescue
          next
        end
      end
    end
  end

  private
  def encrypted_messages
    Dir['files/inputs/*.txt']
  end

  def plain_text_private_key(name)
    File.read("files/keys/#{name}_private_key.pem")
  end
end
