require 'rails_helper'

describe 'admin visits tutorial show page' do
  describe 'tutorial has no videos' do
    it 'displays a message and link to edit tutorial' do
      admin = create(:admin)
      tutorial = create(:tutorial)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit "/tutorials/#{tutorial.id}"

      expect(page).to have_content("No videos in this tutorial")

      click_link "Edit Tutorial"

      expect(current_path).to eq("/admin/tutorials/#{tutorial.id}/edit")
    end
  end
end
