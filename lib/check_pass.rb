# frozen_string_literal: true

require 'bcrypt'

# this class is in charge of checking to see if the entered password is correct.
class CheckPass
  include BCrypt
  def self.check_pass(username, password)
    encrypted_password = Password.new(password)
    creds = ''
    File.open('pass_file', 'r') do |file|
      file.lines do |line|
        creds = line if line.include?(username)
      end
    end
    creds = creds.split(':')

    puts "Successfully logged in as #{username}" if creds[1] == encrypted_password
  end
end