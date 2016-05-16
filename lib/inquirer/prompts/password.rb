require 'inquirer/prompts/input'
require 'inquirer/style/password'

module Password

  extend Input
  extend self

  # this function is necessary to reduce code
  # duplication of the password promt engine
  # to a minimum
  def display_value
    Inquirer::Style::Password.placeholder_char * @value.size
  end
end
