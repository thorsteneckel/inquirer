require 'spec_helper'

describe Paginator do

  paginator = Paginator.new()

  it 'responds to paginate' do
    expect(paginator).to respond_to('paginate')
  end

  it 'keeps small lists untouched' do

    unchanged = <<BLOCK
What is your favorite color?
blue
red
green
BLOCK

    unpaginated = paginator.paginate(unchanged, 3)

    expect(unpaginated).to eq(unchanged)
  end

  it 'paginates long lists postion at top' do


    changed = <<BLOCK
What is your favorite color?
blue
red
green
organge
purple
brown
white
black
silver
yellow
some other color
BLOCK

    paginated = paginator.paginate(changed, 3)

    expected = <<BLOCK
What is your favorite color?

blue
red
green
organge
purple
brown
white

(Move up and down to reveal more choices)
BLOCK
    expect(paginated).to eq(expected)
  end

  it 'paginates long lists postion at bottom' do


    changed = <<BLOCK
What is your favorite color?
blue
red
green
organge
purple
brown
white
black
silver
yellow
some other color
BLOCK

    paginated = paginator.paginate(changed, 7)

    expected = <<BLOCK
What is your favorite color?

purple
brown
white
black
silver
yellow
some other color

(Move up and down to reveal more choices)
BLOCK
    expect(paginated).to eq(expected)
  end
end
