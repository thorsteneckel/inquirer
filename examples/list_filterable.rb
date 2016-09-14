lib = File.expand_path('../../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'inquirer'

questions = [
  {
    name:    :whos_best,
    type:    :list_filterable,
    message: "Who's the best?",
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
        name: 'Tyler',
      },
      {
        name: 'Rust',
      },
      {
        name: 'Marty',
      },
      {
        name: 'Steve',
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
    name:    :whos_best_default_value,
    type:    :list_filterable,
    message: "Who's the best?",
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
    default: :love,
  },
  {
    name:    :whos_best_default_index,
    type:    :list_filterable,
    message: "Who's the best?",
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
    default: 2,
  },
  {
    name:    :whos_best_never,
    type:    :list_filterable,
    message: "Who's the best?",
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
    name:    :whos_best_never_lambda,
    type:    :list_filterable,
    message: "Who's the best?",
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
    name:    :whos_best_when_previous,
    type:    :list_filterable,
    message: "Who's the best?",
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
    when: lambda { |answers| answers[:whos_best_default_index].size > 1 },
  },
  {
    name:    :whos_best_filter_tyler,
    type:    :list_filterable,
    message: "Who's the best?",
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
