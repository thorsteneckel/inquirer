require 'spec_helper'

describe Confirm do

  before :each do
    IOHelper.winsize = [10, 2000]
    IOHelper.output = ''
    IOHelper.keys   = nil
  end

  it "accepts yes answers as true" do

    IOHelper.keys = "y\r".split('')

    response = Confirm.prompt(
      message: 'Are you sure?',
    )

    expect(response).to be true
    expect(IOHelper.output).to eq("\e[32m?\e[0m Are you sure? \e[36mYes\e[0m\n\e[0K\n\e[A")
    expect(IOHelper.output_plain).to eq("? Are you sure? Yes\n\n")
  end

  it "accepts no answers as false" do

    IOHelper.keys = "n\r".split('')

    response = Confirm.prompt(
      message: 'Are you sure?',
    )

    expect(response).to be false
    expect(IOHelper.output).to eq("\e[32m?\e[0m Are you sure? \e[36mNo\e[0m\n\e[0K\n\e[A")
    expect(IOHelper.output_plain).to eq("? Are you sure? No\n\n")
  end

  it "doesn't accept other keys" do

    IOHelper.keys = "z\r".split('')

    response = Confirm.prompt(
      message: 'Are you sure?',
    )

    expect(response).to be_nil
    expect(IOHelper.output).to eq("\e[32m?\e[0m Are you sure? \n\e[0K\n\e[A")
    expect(IOHelper.output_plain).to eq("? Are you sure? \n\n")
  end
end