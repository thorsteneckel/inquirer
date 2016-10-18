require 'spec_helper'

describe CheckboxFilterable do
  include IOHelper::SpecHelpers::All

  it_behaves_like "a Inquirer::Prompts::Checkbox"

  it "filters the value via key input" do

    IOHelper.keys = [
      'e',
      IOChar.key_to_char('down'),
      IOChar.key_to_char('down'),
      IOChar.key_to_char('space'),
      IOChar.key_to_char('down'),
      IOChar.key_to_char('down'),
      IOChar.key_to_char('space'),
      IOChar.key_to_char('return')
    ]

    response = CheckboxFilterable.prompt(
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

    expect(response).to eq([:RedBull, :Weber])
    expect(IOHelper.output).to eq("\e[32m?\e[0m Which brand is your religion? \e[36mRedBull, Weber\e[0m\n\e[0K\n\e[A")
    expect(IOHelper.output_plain).to eq("? Which brand is your religion? RedBull, Weber\n\n")
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
      IOChar.key_to_char('space'),
      IOChar.key_to_char('down'),
      IOChar.key_to_char('down'),
      IOChar.key_to_char('space'),
      IOChar.key_to_char('return'),
    ]

    response = CheckboxFilterable.prompt(
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

    expect(response).to eq([:McDonalds, :Disney])
    expect(IOHelper.output).to eq("\e[32m?\e[0m Which brand is your religion? \e[36mMcDonalds, Disney\e[0m\n\e[0K\n\e[A")
    expect(IOHelper.output_plain).to eq("? Which brand is your religion? McDonalds, Disney\n\n")
  end

  it "removes filter with escape key" do

    IOHelper.keys = [
      'e',
      IOChar.key_to_char('escape'),
      IOChar.key_to_char('down'),
      IOChar.key_to_char('space'),
      IOChar.key_to_char('down'),
      IOChar.key_to_char('down'),
      IOChar.key_to_char('space'),
      IOChar.key_to_char('return')
    ]

    response = CheckboxFilterable.prompt(
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

    expect(response).to eq([:Microsoft, :Starbugs])
    expect(IOHelper.output).to eq("\e[32m?\e[0m Which brand is your religion? \e[36mMicrosoft, Starbugs\e[0m\n\e[0K\n\e[A")
    expect(IOHelper.output_plain).to eq("? Which brand is your religion? Microsoft, Starbugs\n\n")
  end
end