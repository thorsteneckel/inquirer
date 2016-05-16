require 'inquirer/utils/iochar'
require 'inquirer/utils/iohelper'
require 'inquirer/utils/paginator'
require 'inquirer/style/list'

module List

  extend self

  def prompt opts = {}
    @question = opts[:message]
    default   = opts[:default] || 0

    @position  = 0
    @paginator = Paginator.new

    @choices = []
    opts[:choices].each { |choice|

      choice[:value] ||= choice[:name]

      @choices.push(choice)
    }

    return nil if Array(@choices).empty?

    if default.is_a?(String) || default.is_a?(Symbol)
      @position   = @choices.find_index { |choice| choice[:value] == default }
      @position ||= 0
    elsif default.is_a?(Integer) && default < @choices.size
      @position = default
    else
      @position = 0
    end

    IOHelper.without_cursor do

      question_backup = @question
      @question      += ' '
      @question      += Inquirer::Style::List.selection_help

      render_prompt

      @question = question_backup

      IOHelper.read_char do |char|

        key = IOChar.char_to_key(char)

        case key
        when 'up'
          @position = (@position - 1) % @choices.length
        when 'down'
          @position = (@position + 1) % @choices.length
        end

        IOHelper.clear

        render_prompt

        key != 'return'
      end
    end

    IOHelper.clear

    render_result

    @choices[@position][:value]
  end

  def render_prompt
    # start with the question prefix
    prompt = Inquirer::Style.question_prefix

    prompt += Inquirer::Style::List.question % @question

    prompt += IOChar.newline

    prompt += @choices.map.with_index(0) do |choice, position|

      choice_prompt = ''

      if position == @position
        choice_prompt += Inquirer::Style::List.selector
        choice_prompt += ' '
        choice_prompt += Inquirer::Style::List.selected_item % choice[:name]
      else
        choice_prompt += '  '
        choice_prompt += Inquirer::Style::List.item % choice[:name]
      end

      choice_prompt
    end.join('')

    paginated_promt = @paginator.paginate(prompt, @position)

    IOHelper.render( paginated_promt )
  end

  def render_result

    # start with the question prefix
    result = Inquirer::Style.question_prefix

    result += Inquirer::Style::List.question % @question

    display_value = @choices[@position][:short] || @choices[@position][:name]

    result += Inquirer::Style::List.response % display_value

    result += IOChar.newline

    IOHelper.render( result )
  end
end
