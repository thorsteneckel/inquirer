module IOHelper
  extend self

  attr_accessor :output, :bottomline, :keys, :winsize

  def read_char &block
    Array(@keys).each do |key|
      break unless block.(key)
    end
  end

  def render(prompt, bottomline = nil)
    @rendered   = wrap(prompt)
    @bottomline = bottomline

    @output = rendered_output
  end

  def clear
    @output = ''
  end

  def output_plain
    self.plain_chars(output)
  end

  def reset
    clear
    @winsize = [10, 2000]
    @keys    = nil
  end
end

module Inquirer
  def use_inquirer(describe_block, opts)
    describe_block.before opts[:with] do
      IOHelper.reset
    end

    describe_block.after opts[:with] do
      IOHelper.reset
    end
  end

  # Module SpecHelpers
  module SpecHelpers
    include ::Inquirer

    def self.extended(example_group)
      example_group.use_inquirer(example_group, with: :each)
    end

    def self.included(example_group)
      example_group.extend self
    end

    # Module All
    module All
      include ::Inquirer

      def self.extended(example_group)
        example_group.use_inquirer(example_group, with: :all)
      end

      def self.included(example_group)
        example_group.extend self
      end
    end
  end
end
