# encoding: utf-8
require 'spec_helper'

describe Input do

  before :each do
    IOHelper.winsize = [10, 2000]
    IOHelper.output  = ''
    IOHelper.keys    = nil
  end

  it "uses chars value from the user" do

    IOHelper.keys = "Hans Atthilla\r".split('')

    response = Input.prompt(
      message: 'What is your name?',
      default: 'Peter Lästig'
    )

    expect(response).to eq('Hans Atthilla')
    expect(IOHelper.output).to eq("\e[32m?\e[0m What is your name? \e[36mHans Atthilla\e[0m\e[0K\n\e[0K\n\e[A")
    expect(IOHelper.output_plain).to eq("? What is your name? Hans Atthilla\n\n")
  end

  it "uses default if no input" do

    IOHelper.keys = "\r".split('')

    response = Input.prompt(
      message: 'What is your name?',
      default: 'Peter Lästig'
    )

    expect(response).to eq('Peter Lästig')
    expect(IOHelper.output).to eq("\e[32m?\e[0m What is your name? \e[36mPeter Lästig\e[0m\e[0K\n\e[0K\n\e[A")
    expect(IOHelper.output_plain).to eq("? What is your name? Peter Lästig\n\n")
  end

  it "validates inputs" do

    IOHelper.keys = "wrong\r#{ IOChar.key_to_char('backspace') * 5 }correct\r".split('')

    response = Input.prompt(
      message:  'The answer is?',
      default:  'Peter Lästig',
      validate: lambda { |input|
        input == 'correct'
      }
    )

    expect(response).to eq('correct')
    expect(IOHelper.output).to eq("\e[32m?\e[0m The answer is? \e[36mcorrect\e[0m\e[0K\n\e[0K\n\e[A")
    expect(IOHelper.output_plain).to eq("? The answer is? correct\n\n")
  end
end