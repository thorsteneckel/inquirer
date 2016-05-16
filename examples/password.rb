lib = File.expand_path('../../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'inquirer'

questions = [
  {
    name:    :password,
    type:    :password,
    message: 'What should be your password?',
  },
  {
    name:    :password_default,
    type:    :password,
    message: 'What should be your password?',
    default: 'Password',
  },
  {
    name:    :password_never,
    type:    :password,
    message: 'What should be your password?',
    when:    false,
  },
  {
    name:    :password_never_lambda,
    type:    :password,
    message: 'What should be your password?',
    when:    lambda { |answers| true },
  },
  {
    name:    :password_default_password,
    type:    :password,
    message: 'What should be your password?',
    when:    lambda { |answers| answers[:password_default] == 'Password' },
  },
  {
    name:     :password_validate_password,
    type:     :password,
    message:  'What should be your password?',
    validate: lambda { |answer| answer == 'Password' },
  },
  {
    name:     :password_validate_password_message,
    type:     :password,
    message:  'What should be your password?',
    validate: lambda { |answer|
        return true if answer == 'Password'
        'Only Password!'
      },
  },
  {
    name:    :password_filter_password,
    type:    :password,
    message: 'What should be your password?',
    filter:  lambda { |answer|
        'Password'
      },
  },
]

answers = Inquirer.prompt(questions)

p answers
