require 'spec_helper'

describe IOHelper do
  it 'responds to winsize' do
    expect(IOHelper).to respond_to('winsize')
  end
end
