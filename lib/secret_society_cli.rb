# frozen_string_literal: true

require 'bcrypt'

require_relative 'secret_society_cli/version'
require_relative 'user'

module SecretSocietyCli
  class Error < StandardError; end
  
  # contains the entry method for running the cli
  class Cli
    def self.run
      loop do
        User.seed
        puts 'Welcome to the secret keeper!'
        sleep 0.5
        puts 'We are going to need to ask you to sign up or login before we can tell you a secret.'
        sleep 0.5
        puts 'Would you like to login or sign up? (type login or signup or exit)'
        user_input = get_input(%w[login signup exit])
        authenticated_user = evaluate_input user_input
        return unless authenticated_user

        puts 'Looks like you\'re in the cul... I mean secret club. Prepare yourself for the biggest secret
        in the world.'
        sleep 2
        puts 'The cake is a lie'
        sleep 2
        puts 'Bye'
        return
      end
    end

    def self.get_input(valid_inputs)
      # used to get input from the user but must be a valid input from the valid_inputs array
      input = nil
      loop do
        input = gets.chomp
        valid = valid_inputs.select { |acceptable| acceptable == input }
        break if valid.length.positive?

        puts 'Invalid input, please try again.'
      end
      input
    end

    def self.evaluate_input(user_input)
      authenticated_user = nil
      case user_input
      when 'login'
        authenticated_user = User.sign_in
      when 'signup'
        authenticated_user = User.sign_up
      when 'exit'
        puts 'Bye Bye!'
        exit
      end
      authenticated_user
    end
  end
end
