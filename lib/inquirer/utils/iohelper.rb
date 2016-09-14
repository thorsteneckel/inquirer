require 'io/console'
require 'inquirer/utils/iochar'

module IOHelper
  extend self

  @rendered   = ''
  @bottomline = nil

  # Get each key the user presses and hand it one by one to the block. Do this
  # as long as the block returns truthy
  # Params:
  # +&block+:: +Proc+ a block that receives a user key and returns truthy or falsy
  def read_char &block
    STDIN.noecho do
      # as long as the block doen't return falsy,
      # read the user input key and sned it to the block
      while block.( IOHelper.get_char )
      end
    end
  end

  # read a character the user enters on console. This call is synchronous blocking.
  # this is taken from: http://www.alecjacobson.com/weblog/?p=75
  # and: https://gist.github.com/acook/4190379
  def get_char
    begin
      # save previous state of stty
      old_state = `stty -g`
      # disable echoing and enable raw (not having to press enter)
      system 'stty raw -echo'
      char = STDIN.getc.chr
      # gather next two characters of special keys
      if char == "\e"
        char << STDIN.read_nonblock(3) rescue nil
        char << STDIN.read_nonblock(2) rescue nil
      end

      # restore previous state of stty
      system "stty #{old_state}"
    end

    key = IOChar.char_to_key(char)

    if key == 'ctrl-c' or key == 'ctrl-d'
      raise Interrupt
    end

    char
  end

  def winsize
    STDIN.winsize
  end

  # render a text to the prompt
  def render(prompt, bottomline = nil)
    @rendered   = wrap(prompt)
    @bottomline = bottomline

    print rendered_output
  end

  # clear the console based on the last text rendered
  def clear

    # remove the trailing newline, otherwise an upper line will get eaten
    @rendered.sub!(/\n\z/, '')

    # determine how many lines to move up
    lines = @rendered.scan(/\n/).length

    if @bottomline
      print IOChar.cursor_down + IOChar.carriage_return + IOChar.clear_line + IOChar.cursor_up
    end

    # jump back to the first position and clear the line
    print IOChar.cursor_down + IOChar.carriage_return + IOChar.clear_line + IOChar.cursor_up + IOChar.clear_line + IOChar.carriage_return + ( IOChar.cursor_up + IOChar.clear_line ) * lines + IOChar.clear_line
  end

  # hides the cursor and ensure the cursor be visible at the end
  def without_cursor
    # tell the terminal to hide the cursor
    print `tput civis`
    begin
      # run the block
      yield
    ensure
      # tell the terminal to show the cursor
      print `tput cnorm`
    end
  end

  # inspired by http://apidock.com/rails/ActionView/Helpers/TextHelper/word_wrap
  # maybe interesting: https://www.safaribooksonline.com/library/view/ruby-cookbook/0596523696/ch01s15.html
  def wrap(string)

    height, width = IOHelper.winsize

    keep_trailing_newline = false
    if string[-1, 1] == IOChar.newline
      keep_trailing_newline = true
    end

    result = string.split(IOChar.newline).collect! do |line|
      if line.length > width
        line.gsub(/(.{1,#{width}})(\s+|$)/, "\\1#{ IOChar.newline }")
      else
        line
      end
    end * IOChar.newline

    if keep_trailing_newline
      result += IOChar.newline
    else
      result.chomp!
    end

    result + IOChar.clear_line
  end

  def plain_chars(string)
    string.gsub(/\e\[([;\dA-Z]+)?m?/, '')
  end

  private

  def rendered_output

    output = ''

    if @bottomline
      # determine how many lines to move up
      lines   = @rendered.scan(/\n/).size + 1
      output += IOChar.newline * lines + @bottomline + IOChar.cursor_left * @bottomline.size + IOChar.cursor_up * lines
    end
    output += @rendered

    plain_last_line = plain_chars(@rendered.lines.last)
    output += IOChar.newline + IOChar.cursor_up + IOChar.cursor_right * plain_last_line.length

    output
  end
end
