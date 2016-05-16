require 'inquirer/utils/iochar'

class Paginator

  def initialize
    @pointer    = 0
    @last_index = 0
    @page_size  = 7
  end

  def paginate(content, current_position)

    lines_list = content.lines

    # Make sure there's enough lines to paginate
    return content if lines_list.count < (@page_size + 2)

    promt_question = lines_list.shift
    lines_count    = lines_list.count
    infinite       = lines_list * 3

    # Move the pos only when the user go down and limit it to 3
    if @pointer < 3 && @last_index < current_position && current_position - @last_index < 9
      @pointer = [3, @pointer + current_position - @last_index].min
    end
    @last_index = current_position

    top_index = [0, current_position + lines_count - @pointer].max
    section   = infinite.slice(top_index, @page_size).join

    [
      promt_question,
      section,
      Inquirer::Style.pagiator_text + IOChar.newline
    ].join(IOChar.newline)
  end
end