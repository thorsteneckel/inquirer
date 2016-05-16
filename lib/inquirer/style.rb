# encoding: utf-8
require 'term/ansicolor'

module Inquirer
  class Style

    @@color = Term::ANSIColor

    @@question_prefix = @@color.green('?') + ' '
    @@seperator       = '--------'

    @@question = '%s '
    @@response = @@color.cyan('%s')

    @@selector     = @@color.cyan('‣')
    @@checkbox_on  = @@color.green('◉')
    @@checkbox_off = '◯'

    @@pagiator_text = '(Move up and down to reveal more choices)'

    @@error_message               = @@color.red('>>') + ' %s'
    @@error_message_invalid_value = 'The entered value is not valid'

    @@endless_repeat = @@color.yellow('#%s')
    @@limited_repeat = @@color.yellow('#%s of %s')

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