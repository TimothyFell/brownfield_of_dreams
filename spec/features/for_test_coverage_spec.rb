require 'rails_helper'

describe 'LETS GO FOR 100!!!!' do
  it 'covers get_started' do
    visit get_started_path
  end

  it 'covers about' do
    visit about_path
  end
end
