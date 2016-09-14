require 'spec_helper'

describe Inquirer::Style::Confirm do
  it_behaves_like "a Inquirer::Style"

  it 'responds to options' do
    expect(Inquirer::Style::Confirm).to respond_to('options')
  end

  it 'sets and gets options' do
    original = Inquirer::Style::Confirm.options

    Inquirer::Style::Confirm.options = 'test'
    expect(Inquirer::Style::Confirm.options).to eq('test')

    Inquirer::Style::Confirm.options = original
  end

  it 'responds to option_true' do
    expect(Inquirer::Style::Confirm).to respond_to('option_true')
  end

  it 'sets and gets option_true' do
    original = Inquirer::Style::Confirm.option_true

    Inquirer::Style::Confirm.option_true = 'test'
    expect(Inquirer::Style::Confirm.option_true).to eq('test')

    Inquirer::Style::Confirm.option_true = original
  end

  it 'responds to option_false' do
    expect(Inquirer::Style::Confirm).to respond_to('option_false')
  end

  it 'sets and gets option_false' do
    original = Inquirer::Style::Confirm.option_false

    Inquirer::Style::Confirm.option_false = 'test'
    expect(Inquirer::Style::Confirm.option_false).to eq('test')

    Inquirer::Style::Confirm.option_false = original
  end
end