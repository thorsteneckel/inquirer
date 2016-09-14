require 'spec_helper'

describe Inquirer::Style::CheckboxFilterable do
  it_behaves_like "a Inquirer::Style"
  it_behaves_like "a Inquirer::Style::Checkbox"
  it_behaves_like "a Inquirer::Style::*Filterable"
end