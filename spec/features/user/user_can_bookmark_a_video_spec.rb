require 'rails_helper'

describe 'A registered user' do
  it 'can add videos to their bookmarks' do
    tutorial= create(:tutorial, title: "How to Tie Your Shoes")
    video = create(:video, title: "The Bunny Ears Technique", tutorial: tutorial)
    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit tutorial_path(tutorial)

    expect {
      click_on 'Bookmark'
    }.to change { UserVideo.count }.by(1)

    expect(page).to have_content("Bookmark added to your dashboard")
  end

  it "can't add the same bookmark more than once" do
    tutorial= create(:tutorial)
    video = create(:video, tutorial_id: tutorial.id)
    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit tutorial_path(tutorial)

    click_on 'Bookmark'
    expect(page).to have_content("Bookmark added to your dashboard")
    click_on 'Bookmark'
    expect(page).to have_content("Already in your bookmarks")
  end

  it 'can see bookmarks, organized by tutorial, and ordered by position' do
    tutorial_1, tutorial_2 = create_list(:tutorial, 2)
    video_1 = create(:video, tutorial: tutorial_1, position: 100)
    video_2 = create(:video, tutorial: tutorial_1, position: 50)
    video_3 = create(:video, tutorial: tutorial_2)
    video_4 = create(:video, tutorial: tutorial_2)
    user_1, user_2 = create_list(:user, 2)
    user_video_1 = create(:user_video, user: user_1, video: video_1)
    user_video_2 = create(:user_video, user: user_1, video: video_2)
    user_video_3 = create(:user_video, user: user_2, video: video_3)
    user_video_4 = create(:user_video, user: user_1, video: video_4)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

    visit dashboard_path

    expect(page).to have_content("Bookmarked Segments")

    within "bookmarks-#{tutorial_1.id}" do
      expect(page).to have_content(tutorial_1.title)
      expect(all(".bookmark")[0]).to have_content(video_2.title)
      expect(all(".bookmark")[1]).to have_content(video_1.title)
    end

    within "bookmarks-#{tutorial_2.id}" do
      expect(page).to have_content(tutorial_2.title)
      expect(all(".bookmark")[2]).to have_content(video_4.title)
    end
  end
end
