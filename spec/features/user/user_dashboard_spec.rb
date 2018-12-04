require 'rails_helper'

feature 'A user visits their dashboard' do
  scenario 'can see all github repos' do

    stub_request(:get, "https://api.github.com/user/repos").
                  to_return(body: File.read("./spec/fixtures/github_repos_fixture.json"))

    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit '/dashboard'

    expect(page).to have_content("GitHub Repositories")
    expect(page).to have_css(".github_repo", count: 5)
  end
end
