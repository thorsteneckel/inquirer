lib = File.expand_path('../../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'inquirer'

questions = [
  {
    name:    :are_you_sure_type,
    type:    :confirm,
    message: 'Are you sure?',
  },
  {
    name:    :are_you_sure_default,
    type:    :confirm,
    message: 'Are you sure?',
    default: true,
  },
  {
    name:    :are_you_sure_never,
    type:    :confirm,
    message: 'Are you sure?',
    when:    false,
  },
  {
    name:    :are_you_sure_never_lambda,
    type:    :confirm,
    message: 'Are you sure?',
    when:    lambda { |answers| true },
  },
  {
    name:    :are_you_sure_when_previous,
    type:    :confirm,
    message: 'Are you sure?',
    when:    lambda { |answers| answers[:are_you_sure_default] },
  },
  {
    name:     :are_you_sure_validate_true,
    type:     :confirm,
    message:  'Are you sure?',
    validate: lambda { |answer| answer },
  },
  {
    name:     :are_you_sure_validate_true_message,
    type:     :confirm,
    message:  'Are you sure?',
    validate: lambda { |answer|
        return true if answer
        'Only yes!'
      },
  },
  {
    name:    :are_you_sure_filter_tyler,
    type:    :confirm,
    message: 'Are you sure?',
    filter:  lambda { |answer|
        'Tyler'
      },
  },
]

answers = Inquirer.prompt(questions)

p answers
