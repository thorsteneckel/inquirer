require 'spec_helper'

describe Password do

  before :each do
    IOHelper.winsize = [10, 2000]
    IOHelper.output = ''
    IOHelper.keys   = nil
  end

  it "uses chars value from the user" do

    IOHelper.keys = "abcd\r".split('')

    response = Password.prompt(
      message: 'What is your password?',
      default: '12345'
    )

    expect(response).to eq('abcd')
    expect(IOHelper.output).to eq("\e[32m?\e[0m What is your password? \e[36m****\e[0m\e[0K\n\e[0K\n\e[A")
    expect(IOHelper.output_plain).to eq("? What is your password? ****\n\n")
  end

  it "uses default if no input" do

    IOHelper.keys = "\r".split('')

    response = Password.prompt(
      message: 'What is your password?',
      default: '12345'
    )

    expect(response).to eq('12345')
    expect(IOHelper.output).to eq("\e[32m?\e[0m What is your password? \e[36m*****\e[0m\e[0K\n\e[0K\n\e[A")
    expect(IOHelper.output_plain).to eq("? What is your password? *****\n\n")
  end

  it "validates inputs" do

    IOHelper.keys = "wrong\r#{ IOChar.key_to_char('backspace') * 5 }correct\r".split('')

    response = Password.prompt(
      message:  'What is your password?',
      default:  'unknown',
      validate: lambda { |input|
        input == 'correct'
      }
    )

    expect(response).to eq('correct')
    expect(IOHelper.output).to eq("\e[32m?\e[0m What is your password? \e[36m*******\e[0m\e[0K\n\e[0K\n\e[A")
    expect(IOHelper.output_plain).to eq("? What is your password? *******\n\n")
  end
end