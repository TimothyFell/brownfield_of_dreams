require 'rails_helper'

RSpec.describe 'Github::Follower poro' do
   it 'exists' do
    repo = Github::Follower.new({login: "Bob", html_url: "bob.com"})
    expect(repo).to be_instance_of(Github::Follower)
  end

  it 'has attributes' do
    repo = Github::Follower.new({login: "Bob", html_url: "bob.com"})

    expect(repo.name).to eq("Bob")
    expect(repo.url).to eq("bob.com")
  end
end
