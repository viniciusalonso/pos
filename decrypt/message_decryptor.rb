require 'openssl'
require 'base64'

class MessageDecryptor

  def initialize(raw_content_key:)
    @raw_content_key = raw_content_key
    @private_key = OpenSSL::PKey::RSA.new(@raw_content_key)
  end

  def decrypt(content)
    decoded = Base64.decode64(content)
    @private_key.private_decrypt(decoded)
  end
end
