require 'spec_helper'

describe IOChar do
  it 'responds to char_to_key' do
    expect(IOChar).to respond_to('char_to_key')
  end

  it 'responds to key_to_char' do
    expect(IOChar).to respond_to('key_to_char')
  end

  it 'responds to newline' do
    expect(IOChar).to respond_to('newline')
  end

  it 'responds to carriage_return' do
    expect(IOChar).to respond_to('carriage_return')
  end

  it 'responds to cursor_up' do
    expect(IOChar).to respond_to('cursor_up')
  end

  it 'responds to cursor_down' do
    expect(IOChar).to respond_to('cursor_down')
  end

  it 'responds to cursor_right' do
    expect(IOChar).to respond_to('cursor_right')
  end

  it 'responds to cursor_left' do
    expect(IOChar).to respond_to('cursor_left')
  end

  it 'responds to clear_line' do
    expect(IOChar).to respond_to('clear_line')
  end
end
