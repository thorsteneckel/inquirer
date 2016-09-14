RSpec.shared_examples "a Inquirer::Style::List" do
  let(:list) { described_class }

  it 'responds to item' do
    expect(list).to respond_to('item')
  end

  it 'sets and gets item' do
    original = list.item

    list.item = 'test'
    expect(list.item).to eq('test')

    list.item = original
  end

  it 'responds to selected_item' do
    expect(list).to respond_to('selected_item')
  end

  it 'sets and gets selected_item' do
    original = list.selected_item

    list.selected_item = 'test'
    expect(list.selected_item).to eq('test')

    list.selected_item = original
  end

  it 'responds to selection_help' do
    expect(list).to respond_to('selection_help')
  end

  it 'sets and gets selection_help' do
    original = list.selection_help

    list.selection_help = 'test'
    expect(list.selection_help).to eq('test')

    list.selection_help = original
  end
end