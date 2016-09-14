require 'spec_helper'

describe Inquirer::Style::ListFilterable do
  it_behaves_like "a Inquirer::Style"
  it_behaves_like "a Inquirer::Style::List"
  it_behaves_like "a Inquirer::Style::*Filterable"
end