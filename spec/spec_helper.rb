$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'rspec'
require 'inquirer'
require 'simplecov'

require 'inquirer/prompts/checkbox_examples'
require 'inquirer/prompts/list_examples'
require 'inquirer/style/checkbox_examples'
require 'inquirer/style/filterable_examples'
require 'inquirer/style/input_examples'
require 'inquirer/style/list_examples'
require 'inquirer/style_examples'

# Check for coverage stuffs
formatters = []
if ENV['CODECLIMATE_REPO_TOKEN']
  require 'codeclimate-test-reporter'
  formatters << CodeClimate::TestReporter::Formatter
end

if ENV['CODECOV_TOKEN']
  require 'codecov'
  formatters << SimpleCov::Formatter::Codecov
end

unless formatters.empty?
  SimpleCov.formatters = formatters
end

SimpleCov.start do
  # Don't get coverage on the test cases themselves.
  add_filter '/spec/'
  add_filter '/test/'
  # Codecov doesn't automatically ignore vendored files.
  add_filter '/vendor/'
end

module IOHelper
  extend self

  attr_accessor :output, :bottomline, :keys, :winsize

  def read_char &block
    Array(@keys).each do |key|
      break unless block.(key)
    end
  end

  def render(prompt, bottomline = nil)
    @rendered   = wrap(prompt)
    @bottomline = bottomline

    @output = rendered_output
  end

  def clear
    @output = ''
  end

  def output_plain
    self.plain_chars(output)
  end
end
