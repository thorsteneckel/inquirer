# encoding: utf-8
require 'rainbow'

module Inquirer
  class Style

    @@question_prefix = Rainbow('?').green + ' '
    @@seperator       = '--------'

    @@question = '%s '
    @@response = Rainbow('%s').cyan

    @@selector     = Rainbow('‣').cyan
    @@checkbox_on  = Rainbow('◉').green
    @@checkbox_off = '◯'

    @@pagiator_text = '(Move up and down to reveal more choices)'

    @@error_message               = Rainbow('>>').red + ' %s'
    @@error_message_invalid_value = 'The entered value is not valid'

    @@endless_repeat = Rainbow('#%s').yellow
    @@limited_repeat = Rainbow('#%s of %s').yellow

    # http://blog.marc-seeger.de/2011/04/06/attr_reader-for-class-variables-in-ruby/
    def self.activate_getter_setter
      # this creates the methods when the class is loaded
      self.class_variables.each{ |sym|

        # build the meta syntax
        class_variable_getter_and_setter = <<EVALME

    # getter
    def self.#{sym.to_s.gsub('@@','')}
      #{sym}
    end

    # setter
    def self.#{sym.to_s.gsub('@@','')}=(value)
      #{sym} = value
    end;
EVALME
        class_eval(class_variable_getter_and_setter)
      }
    end

    self.activate_getter_setter
  end
end