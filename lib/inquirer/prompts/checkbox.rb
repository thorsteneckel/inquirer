require 'inquirer/utils/paginator'
require 'inquirer/utils/iochar'
require 'inquirer/utils/iohelper'
require 'inquirer/style/checkbox'

module Checkbox

  extend self

  def prompt opts = {}

    # finish if there's nothing to do
    return opts[:default] if Array(opts[:choices]).empty?

    @question  = opts[:message]
    @position  = 0
    @paginator = Paginator.new
    @choices   = []
    opts[:choices].each { |choice|

      choice[:value] ||= choice[:name]

      if !choice[:checked] && opts[:default].is_a?(Array)
        choice[:checked] = opts[:default].include?( choice[:value] )
      end

      @choices.push(choice)
    }

    IOHelper.without_cursor do

      question_backup = @question
      @question      += ' '
      @question      += Inquirer::Style::Checkbox.selection_help

      render_prompt

      @question = question_backup

      # loop through user input
      IOHelper.read_char do |char|

        key = IOChar.char_to_key(char)

        if @error_message
          @error_message = nil
        end

        case key
        when 'up'
          @position = (@position - 1) % @choices.length
        when 'down'
          @position = (@position + 1) % @choices.length
        when 'space'
          @choices[@position][:checked] = !@choices[@position][:checked]
        when 'return'
          if opts[:validate] and opts[:validate].is_a?(Proc)

            value = @choices.reject { |choice|
              !choice[:checked]
            }.collect { |choice|
              choice[:value]
            }

            validation_result = opts[:validate].call( value )

            if !validation_result
              @error_message = Inquirer::Style::Checkbox.error_message_invalid_value
            elsif validation_result && validation_result.is_a?(String)
              @error_message = validation_result
            end
          end
        end

        IOHelper.clear

        render_prompt

        # we are done if the user hits return
        if @error_message or key != 'return'
          true
        else
          false
        end
      end
    end

    render_result

    @choices.reject { |choice|
      !choice[:checked]
    }.collect { |choice|
      choice[:value]
    }
  end

  def render_prompt
    # start with the question prefix
    prompt = Inquirer::Style.question_prefix

    # render the question
    prompt += Inquirer::Style::Checkbox.question % @question

    prompt += IOChar.newline

    # render the list
    prompt += @choices.map.with_index(0) do |choice, position|

      choice_prompt = ''

      if position == @position
        choice_prompt += Inquirer::Style::Checkbox.selector
      else
        choice_prompt += ' '
      end

      if choice[:checked]
        choice_prompt += Inquirer::Style::Checkbox.checkbox_on
        choice_prompt += ' '
        choice_prompt += Inquirer::Style::Checkbox.checked_item % choice[:name]
      else
        choice_prompt += Inquirer::Style::Checkbox.checkbox_off
        choice_prompt += ' '
        choice_prompt += Inquirer::Style::Checkbox.item % choice[:name]
      end

      choice_prompt
    end.join('')

    paginated_prompt = @paginator.paginate(prompt, @position)

    # render error message
    if @error_message
      paginated_prompt += Inquirer::Style::Checkbox.error_message % @error_message
    end

    paginated_prompt += IOChar.carriage_return

    IOHelper.render( paginated_prompt )
  end

  def render_result
    # start with the question prefix
    result = Inquirer::Style.question_prefix

    # render the question
    result += Inquirer::Style::Checkbox.question % @question

    selected_choices = @choices.reject { |choice|
      !choice[:checked]
    }.collect { |choice|
      choice[:short] || choice[:name]
    }.join(', ')

    if !selected_choices.empty?
      result += Inquirer::Style::Checkbox.response % selected_choices
    end

    result += IOChar.newline

    IOHelper.clear

    IOHelper.render( result )
  end
end
