require 'spec_helper'

describe Checkbox do
  it_behaves_like "a Inquirer::Prompts::Checkbox"

  before :each do
    IOHelper.winsize = [10, 2000]
    IOHelper.output  = ''
    IOHelper.keys    = nil
  end
end