require 'io/console'

module IOChar
  extend self

  KEYS = {
    ' '    => 'space',
    "\t"   => 'tab',
    "\r"   => 'return',
    "\n"   => 'linefeed',
    "\e"   => 'escape',
    "\e[A" => 'up',
    "\e[B" => 'down',
    "\e[C" => 'right',
    "\e[D" => 'left',
    "\177" => 'backspace',
    "\003" => 'ctrl-c',
    "\004" => 'ctrl-d',
  }

  def char_to_key char
    KEYS.fetch char, char
  end

  def newline;         "\n"    end
  def carriage_return; "\r"    end
  def cursor_up;       "\e[A"  end
  def cursor_down;     "\e[B"  end
  def cursor_right;    "\e[C"  end
  def cursor_left;     "\e[D"  end
  def clear_line;      "\e[0K" end
end
