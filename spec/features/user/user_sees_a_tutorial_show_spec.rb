require 'rails_helper'

describe 'user visits tutorial show page' do
  describe 'tutorial has no videos' do
    it 'displays a message' do
      user = create(:user)
      tutorial = create(:tutorial)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit "/tutorials/#{tutorial.id}"

      expect(page).to have_content("No videos in this tutorial")

      expect(page).to_not have_content("Edit Tutorial")
    end
  end
end
