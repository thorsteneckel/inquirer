$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'simplecov'
require 'codecov'
require 'codeclimate-test-reporter'

SimpleCov.start do
  # Don't get coverage on the test cases themselves.
  add_filter '/spec/'
  add_filter '/test/'
  # Codecov doesn't automatically ignore vendored files.
  add_filter '/vendor/'
end
SimpleCov.formatter = SimpleCov::Formatter::Codecov

CodeClimate::TestReporter.start

require 'inquirer'
require 'inquirer/prompts/checkbox_examples'
require 'inquirer/prompts/list_examples'
require 'inquirer/style/checkbox_examples'
require 'inquirer/style/filterable_examples'
require 'inquirer/style/input_examples'
require 'inquirer/style/list_examples'
require 'inquirer/style_examples'
require 'inquirer/spec_helpers'