require 'rails_helper'

feature 'A user visits their dashboard' do
  scenario 'can see all github repos' do
    user_1 = create(:user, token: 'token mole')
    user_2 = create(:user, token: 'token pizza')

    stub_request(:get, "https://api.github.com/user/repos").
      with(headers: {"Authorization" => 'token mole'}).
      to_return(body: File.read("./spec/fixtures/github_repos_fixture.json"))

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

    visit '/dashboard'

    expect(page).to have_content("GitHub Repositories")
    expect(page).to have_css(".github_repo", count: 5)
  end

  scenario 'cant see another users repos' do
    user_1 = create(:user, token: 'token mole')
    user_2 = create(:user, token: 'token pizza')

    stub_request(:get, "https://api.github.com/user/repos").
      with(headers: {"Authorization" => 'token mole'}).
      to_return(body: File.read("./spec/fixtures/github_repos_fixture.json"))


    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_2)

    expect { visit '/dashboard'}.to raise_error(ActionView::Template::Error)
  end

  scenario 'user without token does not see repos' do
    user_1 = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

    visit '/dashboard'

    expect(page).to_not have_content("GitHub Repositories")
    expect(page).to_not have_css(".github_repo")
  end
end
