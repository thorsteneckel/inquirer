require 'spec_helper'

describe Inquirer::Style::Password do
  it_behaves_like "a Inquirer::Style"
  it_behaves_like "a Inquirer::Style::Input"
end