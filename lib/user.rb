# frozen_string_literal: true

# represents User and handles authentication
class User
  attr_accessor :username, :password, :users

  @@users = []

  def initialize
    @username = nil
    @password = nil
  end

  def self.generate_password(password)
    BCrypt::Password.create(password)
  end

  def self.sign_in
    puts 'Please provide a username:'
    username = gets.chomp
    puts 'Please provide a password:'
    password = gets.chomp
    selected_user = @@users.select { |user| user.username == username }
    selected_user = selected_user[0]
    if selected_user.nil?
      selected_user = sign_up
      return selected_user
    end

    user_hash = BCrypt::Password.new(selected_user.password)
    selected_user if user_hash == password
  end

  def self.sign_up
    exit unless sign_up?

    @@users.push(credentials)
    puts "#{@@users.last.username} has been added. Thank you!"
    @@users.last
  end

  def self.sign_up?
    user_input = ''
    until user_input.match?(/^Y$|^N$/)
      puts 'Looks like you do not have user account. Would you like to sign up? (Y/N)'
      user_input = gets.chomp
      puts 'Not a valid input. Please try again' unless valid_input? user_input
    end

    return true if user_input.match?('Y')

    false
  end

  def self.valid_input?(user_input)
    return true if user_input.match?(/^Y$|^N$/)

    false
  end

  def self.unique?(username)
    existing_user = @@users.select { |user| user.username == username }
    return false unless existing_user.empty?

    true
  end

  def self.credentials
    user = User.new
    loop do
      puts 'Please enter a new username:'
      user.username = gets.chomp
      puts 'Please enter a new password:'
      user.password = BCrypt::Password.create(gets.chomp)
      break if unique?(user.username)

      puts 'Username is already taken, please try a different one.'
    end
    user
  end

  def self.seed
    user = User.new
    user.username = 'ntruitt'
    user.password = generate_password("password")
    @@users.push(user)
  end
end
