require 'rails_helper'

describe 'a user connected to github' do

  before :each do
    stub_request(:get, "https://api.github.com/user/repos").
      with(headers: {"Authorization" => 'token wakawakawakawakawakawakawakawakawakawaka'}).
      to_return(body: File.read("./spec/fixtures/github_repos_fixture.json"))

    stub_request(:get, "https://api.github.com/user/followers").
      with(headers: {"Authorization" => 'token wakawakawakawakawakawakawakawakawakawaka'}).
      to_return(body: File.read("./spec/fixtures/github_followers_fixture.json"))

    stub_request(:get, "https://api.github.com/user/following").
      with(headers: {"Authorization" => 'token wakawakawakawakawakawakawakawakawakawaka'}).
      to_return(body: File.read("./spec/fixtures/github_following_fixture.json"))

    # Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:github]
    #
    # OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
    #   "provider" => 'github',
    #   "uid" => '123545',
    #   "credentials"=>{"token"=>"wakawakawakawakawakawakawakawakawakawaka"}
    # })
    @user = create(:user, token: "token wakawakawakawakawakawakawakawakawakawaka", guid: 1000)
    @follower = create(:user, token: "token mole", guid: 33760591)
    @following = create(:user, token: "token pizza", guid: 6053806)

  end

  it 'sees a button next to follower that have accounts and are not already friends' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

    visit '/dashboard'

    within '.github_followers' do
      expect(page).to have_css('.add_friend', count: 1)
    end

  end

  it 'sees a message next to follower saying they are alrady friends if already friended' do

  end

  it 'does not see button next to follower if they do not have account in system' do

  end

  it 'sees a button next to following that have accounts and are not already friends' do

  end

  it 'sees a message next to following saying they are alrady friends if already friended' do

  end

  it 'does not see button next to following if they do not have account in system' do

  end

  it 'sees a section containing friends' do

  end
end
