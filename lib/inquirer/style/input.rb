require 'inquirer/style'

module Inquirer
  class Style
    class Input < Inquirer::Style

      @@default  = '(%s) '
      @@value    = '%s'

      self.activate_getter_setter
    end
  end
end
