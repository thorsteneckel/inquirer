RSpec.shared_examples "a Inquirer::Prompts::List" do
  let(:list) { described_class }

  it "returns value instead of name of choice if present" do

    IOHelper.keys = [
      IOChar.key_to_char('down'),
      IOChar.key_to_char('down'),
      IOChar.key_to_char('return')
    ]

    response = list.prompt(
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

    expect(response).to eq(:Google)
    expect(IOHelper.output).to eq("\e[32m?\e[0m Which brand is your religion? \e[36mGoogle\e[0m\n\e[0K\n\e[A")
    expect(IOHelper.output_plain).to eq("? Which brand is your religion? Google\n\n")
  end

  it "returns name of choice if value is not present" do

    IOHelper.keys = [
      IOChar.key_to_char('down'),
      IOChar.key_to_char('down'),
      IOChar.key_to_char('return')
    ]

    response = list.prompt(
      message: 'Which brand is your religion?',
      choices: [
        {
          name: 'Apple',
        },
        {
          name: 'Microsoft',
        },
        {
          name: 'Google',
        },
        {
          name: 'Starbugs',
        },
        {
          name: 'McDonalds',
        },
        {
          name: 'Samsung',
        },
        {
          name: 'RedBull',
        },
        {
          name: 'Disney',
        },
        {
          name: 'Weber',
        },
      ]
    )

    expect(response).to eq('Google')
    expect(IOHelper.output).to eq("\e[32m?\e[0m Which brand is your religion? \e[36mGoogle\e[0m\n\e[0K\n\e[A")
    expect(IOHelper.output_plain).to eq("? Which brand is your religion? Google\n\n")
  end

  it "takes a default parameter by Integer index" do

    IOHelper.keys = [
      IOChar.key_to_char('return')
    ]

    response = list.prompt(
      message: 'Which brand is your religion?',
      default: 1, # starting by 0
      choices: [
        {
          name: 'Apple',
        },
        {
          name: 'Microsoft',
        },
        {
          name: 'Google',
        },
        {
          name: 'Starbugs',
        },
        {
          name: 'McDonalds',
        },
        {
          name: 'Samsung',
        },
        {
          name: 'RedBull',
        },
        {
          name: 'Disney',
        },
        {
          name: 'Weber',
        },
      ]
    )

    expect(response).to eq('Microsoft')
    expect(IOHelper.output).to eq("\e[32m?\e[0m Which brand is your religion? \e[36mMicrosoft\e[0m\n\e[0K\n\e[A")
    expect(IOHelper.output_plain).to eq("? Which brand is your religion? Microsoft\n\n")
  end

  it "takes a default parameter by String" do

    IOHelper.keys = [
      IOChar.key_to_char('return')
    ]

    response = list.prompt(
      message: 'Which brand is your religion?',
      default: 'Microsoft',
      choices: [
        {
          name: 'Apple',
        },
        {
          name: 'Microsoft',
        },
        {
          name: 'Google',
        },
        {
          name: 'Starbugs',
        },
        {
          name: 'McDonalds',
        },
        {
          name: 'Samsung',
        },
        {
          name: 'RedBull',
        },
        {
          name: 'Disney',
        },
        {
          name: 'Weber',
        },
      ]
    )

    expect(response).to eq('Microsoft')
    expect(IOHelper.output).to eq("\e[32m?\e[0m Which brand is your religion? \e[36mMicrosoft\e[0m\n\e[0K\n\e[A")
    expect(IOHelper.output_plain).to eq("? Which brand is your religion? Microsoft\n\n")
  end

  it "takes a default parameter by Symbol" do

    IOHelper.keys = [
      IOChar.key_to_char('return')
    ]

    response = list.prompt(
      message: 'Which brand is your religion?',
      default: :Microsoft,
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

  it "can be scrolled endlessly via up key" do

    IOHelper.keys = [
      IOChar.key_to_char('up'),
      IOChar.key_to_char('return')
    ]

    response = list.prompt(
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

    expect(response).to eq(:Weber)
    expect(IOHelper.output).to eq("\e[32m?\e[0m Which brand is your religion? \e[36mWeber\e[0m\n\e[0K\n\e[A")
    expect(IOHelper.output_plain).to eq("? Which brand is your religion? Weber\n\n")
  end

  it "can be scrolled endlessly via down key" do

    IOHelper.keys = [
      IOChar.key_to_char('down'),
      IOChar.key_to_char('down'),
      IOChar.key_to_char('down'),
      IOChar.key_to_char('down'),
      IOChar.key_to_char('down'),
      IOChar.key_to_char('down'),
      IOChar.key_to_char('down'),
      IOChar.key_to_char('down'),
      IOChar.key_to_char('down'),
      IOChar.key_to_char('return')
    ]

    response = list.prompt(
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

    expect(response).to eq(:Apple)
    expect(IOHelper.output).to eq("\e[32m?\e[0m Which brand is your religion? \e[36mApple\e[0m\n\e[0K\n\e[A")
    expect(IOHelper.output_plain).to eq("? Which brand is your religion? Apple\n\n")
  end

  it "enables choice only if :when returns true" do

    IOHelper.keys = [
      IOChar.key_to_char('down'),
      IOChar.key_to_char('down'),
      IOChar.key_to_char('down'),
      IOChar.key_to_char('down'),
      IOChar.key_to_char('down'),
      IOChar.key_to_char('down'),
      IOChar.key_to_char('down'),
      IOChar.key_to_char('down'),
      IOChar.key_to_char('down'),
      IOChar.key_to_char('return')
    ]

    response = list.prompt(
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
          when: lambda { |when_parameter|
            false
          }
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
          when: lambda { |when_parameter|
            false
          }
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

    expect(response).to eq(:Starbugs)
    expect(IOHelper.output).to eq("\e[32m?\e[0m Which brand is your religion? \e[36mStarbugs\e[0m\n\e[0K\n\e[A")
    expect(IOHelper.output_plain).to eq("? Which brand is your religion? Starbugs\n\n")
  end
end