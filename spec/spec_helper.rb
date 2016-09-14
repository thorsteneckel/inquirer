$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'inquirer'

require 'inquirer/prompts/checkbox_examples'
require 'inquirer/prompts/list_examples'
require 'inquirer/style/checkbox_examples'
require 'inquirer/style/filterable_examples'
require 'inquirer/style/input_examples'
require 'inquirer/style/list_examples'
require 'inquirer/style_examples'

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
