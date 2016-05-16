require 'inquirer/utils/iochar'
require 'inquirer/style'

module Inquirer
  class Style
    class Confirm < Inquirer::Style

      @@options      = '(%s/%s)'
      @@option_true  = 'Yes'
      @@option_false = 'No'

      self.activate_getter_setter
    end
  end
end
