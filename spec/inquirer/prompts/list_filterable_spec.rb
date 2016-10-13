require 'spec_helper'

describe ListFilterable do
  it_behaves_like "a Inquirer::Prompts::List"

  before :each do
    IOHelper.winsize = [10, 2000]
    IOHelper.output  = ''
    IOHelper.keys    = nil
  end

  it "filters the value via key input" do

    IOHelper.keys = [
      'e',
      IOChar.key_to_char('down'),
      IOChar.key_to_char('down'),
      IOChar.key_to_char('return')
    ]

    response = ListFilterable.prompt(
      message: 'Which brand is your religion?',
      choices: [
        {
          name: 'Apple',
          value: :Apple,
        },
        {
          name: 'Microsoft',
          value: :Microsoft,
        },
        {
          name: 'Google',
          value: :Google,
        },
        {
          name: 'Starbugs',
          value: :Starbugs,
        },
        {
          name: 'McDonalds',
          value: :McDonalds,
        },
        {
          name: 'Samsung',
          value: :Samsung,
        },
        {
          name: 'RedBull',
          value: :RedBull,
        },
        {
          name: 'Disney',
          value: :Disney,
        },
        {
          name: 'Weber',
          value: :Weber,
        },
      ]
    )

    expect(response).to eq(:RedBull)
    expect(IOHelper.output).to eq("\e[32m?\e[0m Which brand is your religion? \e[36mRedBull\e[0m\n\e[0K\n\e[A")
    expect(IOHelper.output_plain).to eq("? Which brand is your religion? RedBull\n\n")
  end

  it "prevents selection for invalid filter" do

    IOHelper.keys = [
      'x',
      'x',
      'x',
      IOChar.key_to_char('return'),
      IOChar.key_to_char('backspace'),
      IOChar.key_to_char('backspace'),
      IOChar.key_to_char('backspace'),
      'n',
      IOChar.key_to_char('return'),
    ]

    response = ListFilterable.prompt(
      message: 'Which brand is your religion?',
      choices: [
        {
          name: 'Apple',
          value: :Apple,
        },
        {
          name: 'Microsoft',
          value: :Microsoft,
        },
        {
          name: 'Google',
          value: :Google,
        },
        {
          name: 'Starbugs',
          value: :Starbugs,
        },
        {
          name: 'McDonalds',
          value: :McDonalds,
        },
        {
          name: 'Samsung',
          value: :Samsung,
        },
        {
          name: 'RedBull',
          value: :RedBull,
        },
        {
          name: 'Disney',
          value: :Disney,
        },
        {
          name: 'Weber',
          value: :Weber,
        },
      ]
    )

    expect(response).to eq(:McDonalds)
    expect(IOHelper.output).to eq("\e[32m?\e[0m Which brand is your religion? \e[36mMcDonalds\e[0m\n\e[0K\n\e[A")
    expect(IOHelper.output_plain).to eq("? Which brand is your religion? McDonalds\n\n")
  end

  it "removes filter with escape key" do

    IOHelper.keys = [
      'e',
      IOChar.key_to_char('escape'),
      IOChar.key_to_char('down'),
      IOChar.key_to_char('return')
    ]

    response = ListFilterable.prompt(
      message: 'Which brand is your religion?',
      choices: [
        {
          name: 'Apple',
          value: :Apple,
        },
        {
          name: 'Microsoft',
          value: :Microsoft,
        },
        {
          name: 'Google',
          value: :Google,
        },
        {
          name: 'Starbugs',
          value: :Starbugs,
        },
        {
          name: 'McDonalds',
          value: :McDonalds,
        },
        {
          name: 'Samsung',
          value: :Samsung,
        },
        {
          name: 'RedBull',
          value: :RedBull,
        },
        {
          name: 'Disney',
          value: :Disney,
        },
        {
          name: 'Weber',
          value: :Weber,
        },
      ]
    )

    expect(response).to eq(:Microsoft)
    expect(IOHelper.output).to eq("\e[32m?\e[0m Which brand is your religion? \e[36mMicrosoft\e[0m\n\e[0K\n\e[A")
    expect(IOHelper.output_plain).to eq("? Which brand is your religion? Microsoft\n\n")
  end
end