require 'rails_helper'

RSpec.describe 'Github::Repository poro' do
   it 'exists' do
    repo = Github::Repository.new({name: "Bob", html_url: "bob.com"})
    expect(repo).to be_instance_of(Github::Repository)
  end

  it 'has attributes' do
    repo = Github::Repository.new({name: "Bob", html_url: "bob.com"})

    expect(repo.name).to eq("Bob")
    expect(repo.url).to eq("bob.com")
  end
end
