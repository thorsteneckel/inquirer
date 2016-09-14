RSpec.shared_examples "a Inquirer::Style::Checkbox" do
  let(:checkbox) { described_class }

  it 'responds to item' do
    expect(checkbox).to respond_to('item')
  end

  it 'sets and gets item' do
    original = checkbox.item

    checkbox.item = 'test'
    expect(checkbox.item).to eq('test')

    checkbox.item = original
  end

  it 'responds to checked_item' do
    expect(checkbox).to respond_to('checked_item')
  end

  it 'sets and gets checked_item' do
    original = checkbox.checked_item

    checkbox.checked_item = 'test'
    expect(checkbox.checked_item).to eq('test')

    checkbox.checked_item = original
  end

  it 'responds to selection_help' do
    expect(checkbox).to respond_to('selection_help')
  end

  it 'sets and gets selection_help' do
    original = checkbox.selection_help

    checkbox.selection_help = 'test'
    expect(checkbox.selection_help).to eq('test')

    checkbox.selection_help = original
  end
end