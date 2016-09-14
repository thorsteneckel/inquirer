require 'inquirer/utils/iochar'
require 'inquirer/style'

module Inquirer
  class Style
    class CheckboxFilterable < Inquirer::Style::Checkbox

      @@filter        = '%s'
      @@filter_prefix = @@color.cyan('>') + ' '

      self.activate_getter_setter
    end
  end
end
