require 'inquirer/utils/iochar'
require 'inquirer/utils/iohelper'
require 'inquirer/style/input'

module Input

  extend self

  def prompt opts = {}
    @question = opts[:message]
    @default  = opts[:default]
    @value    = ''

    render_prompt

    cursor_position = 0

    IOHelper.read_char do |char|

      key = IOChar.char_to_key(char)

      @error_message = nil

      case key
      when 'backspace'

        index = @value.size - cursor_position - 1

        if index >= 0
          # remove char at current index
          @value[index] = ''
        end
      when 'left'
        if cursor_position < @value.length
          cursor_position += 1
        end
      when 'right'
        if cursor_position > 0
          cursor_position -= 1
        end
      when 'return'
        if not @default.nil? and @value == ''
          @value = @default.dup
        end

        if opts[:validate] and opts[:validate].is_a?(Proc)

          validation_result = opts[:validate].call( @value )

          if !validation_result
            @error_message = Inquirer::Style::Input.error_message_invalid_value
          elsif validation_result && validation_result.is_a?(String)
            @error_message = validation_result
          end
        end
      else
        if !['up', 'down'].include?(key)

          @value = @value.insert(@value.length - cursor_position, char)
        end
      end

      # flush previous data
      IOHelper.clear

      render_prompt

      update_cursor_position(cursor_position)

      if @error_message or key != 'return'
        true
      else
        false
      end
    end

    render_result

    # return the value
    @value
  end

  def render_prompt

    prompt = Inquirer::Style.question_prefix

    prompt += Inquirer::Style::Input.question % @question

    # render the default value
    if @default
      prompt += Inquirer::Style::Input.default % @default
    end

    # render the input
    prompt += Inquirer::Style::Input.value % display_value

    # render error message
    bottom_line = nil
    if @error_message
      bottom_line = Inquirer::Style::Input.error_message % @error_message
    end

    # rerender new prompt
    IOHelper.render( prompt, bottom_line )
  end

  def render_result

    # start with the question prefix
    result = Inquirer::Style.question_prefix

    # render the question
    result += Inquirer::Style::Input.question % @question

    # render the input
    result += Inquirer::Style::Input.response % display_value

    # finish up
    result += IOChar.clear_line + IOChar.newline

    # flush previous data
    IOHelper.clear

    # rerender result
    IOHelper.render( result )
  end

  def update_cursor_position(cursor_position)
    print IOChar.cursor_left * cursor_position
  end

  # this function is necessary to reduce code
  # duplication of the password promt engine
  # to a minimum
  def display_value
    @value
  end
end
