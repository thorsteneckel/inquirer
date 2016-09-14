RSpec.shared_examples "a Inquirer::Style::*Filterable" do
  let(:filterable) { described_class }

  it 'responds to filter' do
    expect(filterable).to respond_to('filter')
  end

  it 'sets and gets filter' do
    original = filterable.filter

    filterable.filter = 'test'
    expect(filterable.filter).to eq('test')

    filterable.filter = original
  end

  it 'responds to filter_prefix' do
    expect(filterable).to respond_to('filter_prefix')
  end

  it 'sets and gets filter_prefix' do
    original = filterable.filter_prefix

    filterable.filter_prefix = 'test'
    expect(filterable.filter_prefix).to eq('test')

    filterable.filter_prefix = original
  end
end