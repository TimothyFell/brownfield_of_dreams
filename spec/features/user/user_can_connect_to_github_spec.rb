require 'rails_helper'

describe 'A registered user' do

  describe 'when they visit their dashboard' do
    before(:each) do
      stub_request(:get, "https://api.github.com/user/repos").
        with(headers: {"Authorization" => 'token wakawakawakawakawakawakawakawakawakawaka'}).
        to_return(body: File.read("./spec/fixtures/github_repos_fixture.json"))

      stub_request(:get, "https://api.github.com/user/followers").
        with(headers: {"Authorization" => 'token wakawakawakawakawakawakawakawakawakawaka'}).
        to_return(body: File.read("./spec/fixtures/github_followers_fixture.json"))

      stub_request(:get, "https://api.github.com/user/following").
        with(headers: {"Authorization" => 'token wakawakawakawakawakawakawakawakawakawaka'}).
        to_return(body: File.read("./spec/fixtures/github_following_fixture.json"))

      Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:github]

      OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
        "provider" => 'github',
        "uid" => '123545',
        "credentials"=>{"token"=>"wakawakawakawakawakawakawakawakawakawaka"}
      })
    end

    it 'they can connect to their github account' do
      user = create(:user)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/dashboard'

      click_link 'Connect to Github'

      connected_user = User.find(user.id)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(connected_user)

      visit '/dashboard'

      expect(connected_user.id).to eq(user.id)
      expect(page).to_not have_link("Connect to Github")
      expect(connected_user.token).to eq("token wakawakawakawakawakawakawakawakawakawaka")
    end


    xit "can handle authentication error" do
      user = create(:user)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      OmniAuth.config.mock_auth[:github] = :invalid_credentials

      visit '/dashboard'

      expect(page).to have_content("Connect to Github")
      click_link "Connect to Github"
      expect(page).to have_content('Authentication failed.')
    end

    describe 'After connecting' do

      it 'they can see 5 github repos from github' do
        user = create(:user)

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

        visit '/dashboard'

        click_link 'Connect to Github'

        connected_user = User.find(user.id)

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(connected_user)

        visit '/dashboard'

        expect(page).to have_content("GitHub Repositories")
        expect(page).to have_css(".github_repo", count: 5)
      end

      it 'they can see 11 followers from github' do
        user = create(:user)

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

        visit '/dashboard'

        click_link 'Connect to Github'

        connected_user = User.find(user.id)

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(connected_user)

        visit '/dashboard'

        expect(page).to have_content("GitHub Followers")
        expect(page).to have_css(".github_follower", count: 11)
      end

      it 'they can see 30 followings from github' do
        user = create(:user)

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

        visit '/dashboard'

        click_link 'Connect to Github'

        connected_user = User.find(user.id)

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(connected_user)

        visit '/dashboard'

        expect(page).to have_content("GitHub Following")
        expect(page).to have_css(".github_following", count: 30)
      end


    end

  end

end
