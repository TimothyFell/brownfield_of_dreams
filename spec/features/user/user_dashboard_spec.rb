require 'rails_helper'

feature 'A user visits their dashboard' do
  scenario 'can see all github repos' do

    stub_request(:get, "https://api.github.com/user/repos").
                  to_return(body: File.read("./spec/fixtures/github_repos_fixture.json"))

    user = create(:user, token: ENV['GITHUB_API_KEY_1'])
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit '/dashboard'

    expect(page).to have_content("GitHub Repositories")
    expect(page).to have_css(".github_repo", count: 5)
  end

  scenario 'cant see another users repos' do
    stub_request(:get, "https://api.github.com/user/repos").
      to_return(body: File.read("./spec/fixtures/github_repos_fixture.json"))

    user_1 = create(:user, token: ENV['GITHUB_API_KEY_1'])
    user_2s_data = JSON.parse(File.read("./spec/fixtures/github_repos_2_fixture.json")).first

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

    visit '/dashboard'

    expect(page).to_not have_css(".repo_id_#{user_2s_data['id']}")
  end
end
