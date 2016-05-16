require 'inquirer/style'

module Inquirer
  class Style
    class Password < Inquirer::Style::Input

      @@placeholder_char = '*'

      self.activate_getter_setter
    end
  end
end
