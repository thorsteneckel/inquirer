require 'inquirer/utils/iochar'
require 'inquirer/style'

module Inquirer
  class Style
    class List < Inquirer::Style

      @@item          = "%s#{IOChar.newline}"
      @@selected_item = @@color.cyan('%s') + IOChar.newline

      @@selection_help = '(Use arrow keys)'

      self.activate_getter_setter
    end
  end
end
