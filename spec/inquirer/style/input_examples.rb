RSpec.shared_examples "a Inquirer::Style::Input" do
  let(:input) { described_class }

  it 'responds to default' do
    expect(input).to respond_to('default')
  end

  it 'sets and gets default' do
    original = input.default

    input.default = 'test'
    expect(input.default).to eq('test')

    input.default = original
  end

  it 'responds to value' do
    expect(input).to respond_to('value')
  end

  it 'sets and gets value' do
    original = input.value

    input.value = 'test'
    expect(input.value).to eq('test')

    input.value = original
  end
end