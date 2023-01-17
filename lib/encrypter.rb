# frozen_string_literal: true

require 'bcrypt'

# used to generate password file and generate credentials
class Encrypter
  include BCrypt
  def self.generate_password_file(file_path)
    File.open(file_path, 'w') do |file|
      file.puts 'Ultimate Password File'
    end
  end

  def self.generate_cred(username, password)
    encrypted_password = Password.new(password)
    generate_password_file('./pass_file') unless File.exist?('./pass_file')
    File.open('./pass_file', 'w') do |file|
      file.puts "#{username}:#{encrypted_password}"
    end
  end
end