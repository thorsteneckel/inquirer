require 'inquirer/utils/iochar'
require 'inquirer/utils/iohelper'
require 'inquirer/utils/paginator'
require 'inquirer/style/list_filterable'

module ListFilterable

  extend self

  def prompt opts = {}
    @question = opts[:message]
    default   = opts[:default] || 0

    @position  = 0
    @paginator = Paginator.new

    @choices = []
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

      @choices.push(choice)
    }

    return nil if Array(@choices).empty?

    return @choices[0][:value] if @choices.size == 1

    if default.is_a?(String) || default.is_a?(Symbol)
      @position   = @choices.find_index { |choice| choice[:value] == default }
      @position ||= 0
    elsif default.is_a?(Integer) && default < @choices.size
      @position = default
    else
      @position = 0
    end


    question_backup = @question
    @question      += ' '
    @question      += Inquirer::Style::ListFilterable.selection_help

    @filter           = ''
    cursor_position   = 0
    @choices_filtered = @choices
    @question         = question_backup

    render_prompt

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
      when 'escape'
        @filter = ''

        filter_choices
      else

        if !['return'].include?(key)
          @filter = @filter.insert(@filter.length - cursor_position, char)
          filter_choices
        end
      end

      IOHelper.clear

      render_prompt

      update_cursor_position(cursor_position)

      key != 'return' || @choices_filtered.empty?
    end

    IOHelper.clear

    render_result

    @choices_filtered[@position][:value]
  end

  def render_prompt
    # start with the question prefix
    prompt = Inquirer::Style.question_prefix

    prompt += Inquirer::Style::ListFilterable.question % @question

    prompt += IOChar.newline

    prompt += @choices_filtered.map.with_index(0) do |choice, position|

      choice_prompt = ''

      if position == @position
        choice_prompt += Inquirer::Style::ListFilterable.selector
        choice_prompt += ' '
        choice_prompt += Inquirer::Style::ListFilterable.selected_item % choice[:name]
      else
        choice_prompt += '  '
        choice_prompt += Inquirer::Style::ListFilterable.item % choice[:name]
      end

      choice_prompt
    end.join('')

    paginated_prompt = @paginator.paginate(prompt, @position)

    # render error message
    if @error_message
      paginated_prompt += Inquirer::Style::ListFilterable.error_message % @error_message
    end

    paginated_prompt += IOChar.newline

    paginated_prompt += Inquirer::Style::ListFilterable.filter_prefix

    paginated_prompt += Inquirer::Style::ListFilterable.filter % @filter

    IOHelper.render( paginated_prompt )
  end

  def render_result

    # start with the question prefix
    result = Inquirer::Style.question_prefix

    result += Inquirer::Style::ListFilterable.question % @question

    display_value = @choices_filtered[@position][:short] || @choices_filtered[@position][:name]

    result += Inquirer::Style::ListFilterable.response % display_value

    result += IOChar.newline

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
