require 'inquirer/utils/iochar'
require 'inquirer/utils/iohelper'
require 'inquirer/style/confirm'

module Confirm

  extend self

  def prompt opts = {}
    @question = opts[:message]
    @default  = opts[:default]
    @value    = nil

    render_prompt

    IOHelper.read_char do |char|

      key = IOChar.char_to_key(char)

      if key.casecmp( Inquirer::Style::Confirm.option_true[0] ) == 0
        @value = true
        false
      elsif key.casecmp( Inquirer::Style::Confirm.option_false[0] ) == 0
        @value = false
        false
      elsif key == 'return' and !@default.nil?
        @value = @default
        false
      else
        true
      end
    end

    render_result

    @value
  end

  def render_prompt

    options = [
      Inquirer::Style::Confirm.option_true[0].downcase,
      Inquirer::Style::Confirm.option_false[0].downcase
    ]
    if !@default.nil?
      if @default
        options[0].capitalize!
      else
        options[1].capitalize!
      end
    end

    # start with the question prefix
    prompt = Inquirer::Style.question_prefix

    prompt += Inquirer::Style::Confirm.question % @question

    prompt += Inquirer::Style::Confirm.options % options

    prompt += ' '

    IOHelper.render( prompt )
  end

  def render_result

    response = nil
    if @value
      response = Inquirer::Style::Confirm.option_true
    else
      response = Inquirer::Style::Confirm.option_false
    end

    # start with the question prefix
    result = Inquirer::Style.question_prefix

    result += Inquirer::Style::Confirm.question % @question

    result += Inquirer::Style::Confirm.response % response

    result += IOChar.newline

    # flush previous data
    IOHelper.clear

    # rerender result
    IOHelper.render( result )
  end
end
