lib = File.expand_path('../../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'inquirer'

questions = [
  {
    name:    :user_name_no_type,
    message: 'What is your name?',
  },
  {
    name:    :user_name_type,
    type:    :input,
    message: 'What is your name?',
  },
  {
    name:    :user_name_default_tyler,
    type:    :input,
    message: 'What is your name?',
    default: 'Tyler',
  },
  {
    name:    :user_name_never,
    type:    :input,
    message: 'What is your name?',
    when:    false,
  },
  {
    name:    :user_name_never_lambda,
    type:    :input,
    message: 'What is your name?',
    when:    lambda { |answers| true },
  },
  {
    name:    :user_name_when_tyler,
    type:    :input,
    message: 'What is your name?',
    when:    lambda { |answers| answers[:user_name_default] == 'Tyler' },
  },
  {
    name:     :user_name_validate_tyler,
    type:     :input,
    message:  'What is your name?',
    validate: lambda { |answer| answer == 'Tyler' },
  },
  {
    name:     :user_name_validate_tyler_message,
    type:     :input,
    message:  'What is your name?',
    validate: lambda { |answer|
        return true if answer == 'Tyler'
        'Only Tyler!'
      },
  },
  {
    name:    :user_name_filter_tyler,
    type:    :input,
    message: 'What is your name?',
    filter:  lambda { |answer|
        'Tyler'
      },
  },
]

answers = Inquirer.prompt(questions)

p answers
