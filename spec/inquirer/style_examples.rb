RSpec.shared_examples "a Inquirer::Style" do
  let(:style) { described_class }

  it 'responds to question_prefix' do
    expect(style).to respond_to('question_prefix')
  end

  it 'sets and gets question_prefix' do
    original = style.question_prefix

    style.question_prefix = 'test'
    expect(style.question_prefix).to eq('test')

    style.question_prefix = original
  end

  it 'responds to seperator' do
    expect(style).to respond_to('seperator')
  end

  it 'sets and gets seperator' do
    original = style.seperator

    style.seperator = 'test'
    expect(style.seperator).to eq('test')

    style.seperator = original
  end

  it 'responds to question' do
    expect(style).to respond_to('question')
  end

  it 'sets and gets question' do
    original = style.question

    style.question = 'test'
    expect(style.question).to eq('test')

    style.question = original
  end

  it 'responds to response' do
    expect(style).to respond_to('response')
  end

  it 'sets and gets response' do
    original = style.response

    style.response = 'test'
    expect(style.response).to eq('test')

    style.response = original
  end

  it 'responds to selector' do
    expect(style).to respond_to('selector')
  end

  it 'sets and gets selector' do
    original = style.selector

    style.selector = 'test'
    expect(style.selector).to eq('test')

    style.selector = original
  end

  it 'responds to checkbox_on' do
    expect(style).to respond_to('checkbox_on')
  end

  it 'sets and gets checkbox_on' do
    original = style.checkbox_on

    style.checkbox_on = 'test'
    expect(style.checkbox_on).to eq('test')

    style.checkbox_on = original
  end

  it 'responds to checkbox_off' do
    expect(style).to respond_to('checkbox_off')
  end

  it 'sets and gets checkbox_off' do
    original = style.checkbox_off

    style.checkbox_off = 'test'
    expect(style.checkbox_off).to eq('test')

    style.checkbox_off = original
  end

  it 'responds to pagiator_text' do
    expect(style).to respond_to('pagiator_text')
  end

  it 'sets and gets pagiator_text' do
    original = style.pagiator_text

    style.pagiator_text = 'test'
    expect(style.pagiator_text).to eq('test')

    style.pagiator_text = original
  end

  it 'responds to error_message' do
    expect(style).to respond_to('error_message')
  end

  it 'sets and gets error_message' do
    original = style.error_message

    style.error_message = 'test'
    expect(style.error_message).to eq('test')

    style.error_message = original
  end

  it 'responds to error_message_invalid_value' do
    expect(style).to respond_to('error_message_invalid_value')
  end

  it 'sets and gets error_message_invalid_value' do
    original = style.error_message_invalid_value

    style.error_message_invalid_value = 'test'
    expect(style.error_message_invalid_value).to eq('test')

    style.error_message_invalid_value = original
  end

  it 'responds to endless_repeat' do
    expect(style).to respond_to('endless_repeat')
  end

  it 'sets and gets endless_repeat' do
    original = style.endless_repeat

    style.endless_repeat = 'test'
    expect(style.endless_repeat).to eq('test')

    style.endless_repeat = original
  end

  it 'responds to limited_repeat' do
    expect(style).to respond_to('limited_repeat')
  end

  it 'sets and gets limited_repeat' do
    original = style.limited_repeat

    style.limited_repeat = 'test'
    expect(style.limited_repeat).to eq('test')

    style.limited_repeat = original
  end
end