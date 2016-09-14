lib = File.expand_path('../../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'inquirer'

questions = [
  {
    name:    :invitation,
    type:    :checkbox_filterable,
    message: 'Who should get invited?',
    choices: [
      {
        name:  'Karl',
        short: 'Kalli',
      },
      {
        name:  'Bert',
        value: "It's Bert!"
      },
      {
        name:  'Berta',
        value: :love
      },
      {
        name: 'Manfred',
      },
      {
        name: 'Holger',
        when: lambda { |_args| false }
      },
      {
        name: 'Tanja',
        when: true
      },
    ],
  },
  {
    name:    :invitation_default,
    type:    :checkbox_filterable,
    message: 'Who should get invited?',
    choices: [
      {
        name:  'Karl',
        short: 'Kalli',
      },
      {
        name:  'Bert',
        value: "It's Bert!"
      },
      {
        name:  'Berta',
        value: :love
      },
      {
        name: 'Manfred',
      },
    ],
    default:  [
      "It's Bert!",
      :love,
      'Manfred',
    ],
  },
  {
    name:    :invitation_never,
    type:    :checkbox_filterable,
    message: 'Who should get invited?',
    choices: [
      {
        name:  'Karl',
        short: 'Kalli',
      },
      {
        name:  'Bert',
        value: "It's Bert!"
      },
      {
        name:  'Berta',
        value: :love
      },
      {
        name: 'Manfred',
      },
    ],
    when: false,
  },
  {
    name:    :invitation_never_lambda,
    type:    :checkbox_filterable,
    message: 'Who should get invited?',
    choices: [
      {
        name:  'Karl',
        short: 'Kalli',
      },
      {
        name:  'Bert',
        value: "It's Bert!"
      },
      {
        name:  'Berta',
        value: :love
      },
      {
        name: 'Manfred',
      },
    ],
    when:    lambda { |answers| true },
  },
  {
    name:    :invitation_when_previous,
    type:    :checkbox_filterable,
    message: 'Who should get invited?',
    choices: [
      {
        name:  'Karl',
        short: 'Kalli',
      },
      {
        name:  'Bert',
        value: "It's Bert!"
      },
      {
        name:  'Berta',
        value: :love
      },
      {
        name: 'Manfred',
      },
    ],
    when: lambda { |answers| answers[:invitation_default].size > 1 },
  },
  {
    name:     :invitation_validate_size,
    type:     :checkbox_filterable,
    message:  'Who should get invited?',
    choices: [
      {
        name:  'Karl',
        short: 'Kalli',
      },
      {
        name:  'Bert',
        value: "It's Bert!"
      },
      {
        name:  'Berta',
        value: :love
      },
      {
        name: 'Manfred',
      },
    ],
    validate: lambda { |answer| answer.size == 2 },
  },
  {
    name:     :invitation_validate_tyler_message,
    type:     :checkbox_filterable,
    message:  'Who should get invited?',
    choices: [
      {
        name:  'Karl',
        short: 'Kalli',
      },
      {
        name:  'Bert',
        value: "It's Bert!"
      },
      {
        name:  'Berta',
        value: :love
      },
      {
        name: 'Manfred',
      },
    ],
    validate: lambda { |answer|
        return true if answer.include? 'Tyler'
        'Only Tyler!'
      },
  },
  {
    name:    :invitation_filter_tyler,
    type:    :checkbox_filterable,
    message: 'Who should get invited?',
    choices: [
      {
        name:  'Karl',
        short: 'Kalli',
      },
      {
        name:  'Bert',
        value: "It's Bert!"
      },
      {
        name:  'Berta',
        value: :love
      },
      {
        name: 'Manfred',
      },
    ],
    filter:  lambda { |answer|
        ['Tyler']
      },
  },
]

answers = Inquirer.prompt(questions)

p answers
