require 'inquirer/utils/paginator'
require 'inquirer/utils/iochar'
require 'inquirer/utils/iohelper'
require 'inquirer/style/checkbox_filterable'

module CheckboxFilterable

  extend self

  def prompt opts = {}

    # finish if there's nothing to do
    return opts[:default] if Array(opts[:choices]).empty?

    @question  = opts[:message]
    @position  = 0
    @paginator = Paginator.new
    @choices   = []
    opts[:choices].each { |choice|

      if choice[:when].is_a?(Proc)

        when_parameter = opts.merge(
          choice: choice,
        )

        ask_choice = choice[:when].call( when_parameter )

        next if !ask_choice
      elsif [true, false].include? choice[:when]
        next if !choice[:when]
      end

      choice[:value] ||= choice[:name]

      if !choice[:checked] && opts[:default].is_a?(Array)
        choice[:checked] = opts[:default].include?( choice[:value] )
      end

      @choices.push(choice)
    }

    question_backup = @question
    @question      += ' '
    @question      += Inquirer::Style::CheckboxFilterable.selection_help

    @filter           = ''
    cursor_position   = 0
    @choices_filtered = @choices
    @question         = question_backup

    render_prompt

    # loop through user input
    IOHelper.read_char do |char|

      key = IOChar.char_to_key(char)

      if @error_message
        @error_message = nil
      end

      case key
      when 'up'
        if !@choices_filtered.empty?
          @position = (@position - 1) % @choices_filtered.length
        else
          check_no_match
        end
      when 'down'
        if !@choices_filtered.empty?
          @position = (@position + 1) % @choices_filtered.length
        else
          check_no_match
        end
      when 'space'
        if !@choices_filtered.empty?
          @choices_filtered[@position][:checked] = !@choices_filtered[@position][:checked]

          choice = @choices_filtered[@position]

          @choices.map! {|possible_choice|

            if choice[:name] == possible_choice[:name]
              possible_choice = choice
            end

            possible_choice
          }
        end
      when 'return'
        if opts[:validate] and opts[:validate].is_a?(Proc)

          value = @choices.reject { |choice|
            !choice[:checked]
          }.collect { |choice|
            choice[:value]
          }

          validation_result = opts[:validate].call( value )

          if !validation_result
            @error_message = Inquirer::Style::CheckboxFilterable.error_message_invalid_value
          elsif validation_result && validation_result.is_a?(String)
            @error_message = validation_result
          end
        end

        if !@error_message
          check_no_match
        end
      when 'backspace'

        index = @filter.size - cursor_position - 1

        if index >= 0
          # remove char at current index
          @filter[index] = ''
        end

        filter_choices
      when 'left'
        if cursor_position < @filter.length
          cursor_position += 1
        end

        check_no_match
      when 'right'
        if cursor_position > 0
          cursor_position -= 1
        end

        check_no_match
      else
        @filter = @filter.insert(@filter.length - cursor_position, char)

        filter_choices
      end

      IOHelper.clear

      render_prompt

      update_cursor_position(cursor_position)

      # we are done if the user hits return
      @error_message || key != 'return'
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
    prompt += Inquirer::Style::CheckboxFilterable.question % @question

    prompt += IOChar.newline

    # render the list
    prompt += @choices_filtered.map.with_index(0) do |choice, position|

      choice_prompt = ''

      if position == @position
        choice_prompt += Inquirer::Style::CheckboxFilterable.selector
      else
        choice_prompt += ' '
      end

      if choice[:checked]
        choice_prompt += Inquirer::Style::CheckboxFilterable.checkbox_on
        choice_prompt += ' '
        choice_prompt += Inquirer::Style::CheckboxFilterable.checked_item % choice[:name]
      else
        choice_prompt += Inquirer::Style::CheckboxFilterable.checkbox_off
        choice_prompt += ' '
        choice_prompt += Inquirer::Style::CheckboxFilterable.item % choice[:name]
      end

      choice_prompt
    end.join('')

    paginated_prompt = @paginator.paginate(prompt, @position)

    # render error message
    if @error_message
      paginated_prompt += Inquirer::Style::CheckboxFilterable.error_message % @error_message
    end

    paginated_prompt += IOChar.newline

    paginated_prompt += Inquirer::Style::CheckboxFilterable.filter_prefix

    paginated_prompt += Inquirer::Style::CheckboxFilterable.filter % @filter

    IOHelper.render( paginated_prompt )
  end

  def render_result
    # start with the question prefix
    result = Inquirer::Style.question_prefix

    # render the question
    result += Inquirer::Style::CheckboxFilterable.question % @question

    selected_choices = @choices.reject { |choice|
      !choice[:checked]
    }.collect { |choice|
      choice[:short] || choice[:name]
    }.join(', ')

    if !selected_choices.empty?
      result += Inquirer::Style::CheckboxFilterable.response % selected_choices
    end

    result += IOChar.newline

    IOHelper.clear

    IOHelper.render( result )
  end

  def update_cursor_position(cursor_position)
    print IOChar.cursor_left * cursor_position
  end

  def filter_choices
    @position         = 0
    @choices_filtered = []

    @choices.each { |choice|

      next if !choice[:name].gsub(/\s/, '').downcase.index(@filter.gsub(/\s/, '').downcase)

      @choices_filtered.push(choice)
    }

    check_no_match
  end

  def check_no_match
    return if !@choices_filtered.empty?

    @error_message = 'No matching choice found'
  end
end
