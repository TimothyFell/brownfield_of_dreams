require 'rails_helper'

describe 'A user visits their dashboard' do

  before(:each) do
    stub_request(:get, "https://api.github.com/user/repos").
      with(headers: {"Authorization" => 'token mole'}).
      to_return(body: File.read("./spec/fixtures/github_repos_fixture.json"))

    stub_request(:get, "https://api.github.com/user/followers").
      with(headers: {"Authorization" => 'token mole'}).
      to_return(body: File.read("./spec/fixtures/github_followers_fixture.json"))

    stub_request(:get, "https://api.github.com/user/following").
      with(headers: {"Authorization" => 'token mole'}).
      to_return(body: File.read("./spec/fixtures/github_following_fixture.json"))
  end

  it 'they should see a link to invite a github person' do
    user = create(:user, token: 'token mole', active: true)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path

    expect(page).to have_content('Send an Invite')
    expect(page).to have_css('.invite_link')
  end

  it 'after clicking on the link the user should be on /invite' do
    user = create(:user, token: 'token mole', active: true)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path

    click_link 'Send an Invite'

    expect(current_path).to eq invite_path
  end

  it 'on /invite user sees a form and after filling it out are redirected to their dashboard' do
    stub_request(:get, "https://api.github.com/users/iandouglas").
      with(headers: {"Authorization" => 'token mole'}).
      to_return(body: File.read("./spec/fixtures/invitation_fixture.json"))

    user = create(:user, github_name: 'TimFell', token: 'token mole', active: true)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit invite_path

    fill_in 'Github Handle', with: 'iandouglas'
    click_on 'Send Invite'

    open_email('ian.douglas@iandouglas.com')
    expect(current_email).to have_content("Hello Ian Douglas")
    expect(current_email).to have_content("TimFell has invited you to join Brownfield of Dreams.")
    expect(current_email).to have_link('here')

    expect(current_path).to eq dashboard_path
    expect(page).to have_content("Successfully sent invite!")
  end

  it 'if they put in a user without a public email should fail' do
    stub_request(:get, "https://api.github.com/users/iandouglas").
      with(headers: {"Authorization" => 'token mole'}).
      to_return(body: File.read("./spec/fixtures/sad_invitation_fixture.json"))

    user = create(:user, github_name: 'TimFell', token: 'token mole', active: true)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit invite_path

    fill_in 'Github Handle', with: 'iandouglas'
    click_on 'Send Invite'

    expect(current_path).to eq dashboard_path
    expect(page).to have_content("The Github user you selected doesn't have an email address associated with their account.")
  end



end
