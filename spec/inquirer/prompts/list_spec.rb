require 'spec_helper'

describe List do
  it_behaves_like "a Inquirer::Prompts::List"

  before :each do
    IOHelper.winsize = [10, 2000]
    IOHelper.output  = ''
    IOHelper.keys    = nil
  end
end