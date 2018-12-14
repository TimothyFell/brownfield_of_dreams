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

  it 'can friend a follower' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

    visit '/dashboard'
    within '.github_followers' do
      click_link 'Add Friend'
    end

    within '.github_followers' do
      expect(page).to have_content('Already Friends!', count: 1)
    end
  end

  it 'does not see button next to follower if they do not have account in system' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

    visit '/dashboard'

    within '.follower_id_38509894' do
      expect(page).to_not have_css('.add_friend')
    end
  end

  it 'sees a button next to following that have accounts and are not already friends' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

    visit '/dashboard'

    within '.github_followings' do
      expect(page).to have_css('.add_friend', count: 1)
    end
  end

  it 'can friend a following' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

    visit '/dashboard'
    within '.github_followings' do
      click_link 'Add Friend'
    end

    within '.github_followings' do
      expect(page).to have_content('Already Friends!', count: 1)
    end
  end

  it 'does not see button next to following if they do not have account in system' do

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

    visit '/dashboard'

    within '.following_id_8962411' do
      expect(page).to_not have_css('.add_friend')
    end

  end

  it 'sees a section containing friends' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

    visit '/dashboard'

    within '.github_followers' do
      click_link 'Add Friend'
    end

    within '.github_followings' do
      click_link 'Add Friend'
    end

    within '.friends' do
      expect(page).to have_css('.friend', count: 2)
    end
  end

  it 'should not be able to friend non-existant users' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

    visit dashboard_path

    page.driver.post("/users/#{@user.id}/add_friend/0987654321")
    click_on "redirected"

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content('That is an invalid user to friend!')
  end

end
