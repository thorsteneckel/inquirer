require 'inquirer/utils/iochar'
require 'inquirer/style'

module Inquirer
  class Style
    class Checkbox < Inquirer::Style

      @@item         = "%s#{IOChar.newline}"
      @@checked_item = "%s#{IOChar.newline}"

      @@selection_help = '(Press <space> to select)'

      self.activate_getter_setter
    end
  end
end
