require 'rails_helper'

describe 'Visitor' do
  describe 'on the home page' do
    it 'can see a list of tutorials' do
      tutorial1 = create(:tutorial)
      tutorial2 = create(:tutorial)

      video1 = create(:video, tutorial_id: tutorial1.id)
      video2 = create(:video, tutorial_id: tutorial1.id)
      video3 = create(:video, tutorial_id: tutorial2.id)
      video4 = create(:video, tutorial_id: tutorial2.id)

      visit root_path

      expect(page).to have_css('.tutorial', count: 2)

      within(first('.tutorials')) do
        expect(page).to have_css('.tutorial')
        expect(page).to have_css('.tutorial-description')
        expect(page).to have_content(tutorial1.title)
        expect(page).to have_content(tutorial1.description)
      end
    end

    it "can't see tutorials that are marked as classroom content" do
      tutorial1 = create(:tutorial)
      tutorial2 = create(:tutorial)
      tutorial3 = create(:tutorial, classroom: true)

      video1 = create(:video, tutorial_id: tutorial1.id)
      video2 = create(:video, tutorial_id: tutorial1.id)
      video3 = create(:video, tutorial_id: tutorial2.id)
      video4 = create(:video, tutorial_id: tutorial2.id)
      video5 = create(:video, tutorial_id: tutorial3.id)
      video6 = create(:video, tutorial_id: tutorial3.id)

      visit root_path

      expect(page).to have_css('.tutorial', count: 2)

      within(first('.tutorials')) do
        expect(page).to have_css('.tutorial')
        expect(page).to have_css('.tutorial-description')
        expect(page).to have_content(tutorial1.title)
        expect(page).to have_content(tutorial1.description)
      end

      expect(page).to_not have_content(tutorial3.title)
      expect(page).to_not have_content(tutorial3.description)
    end

    it "can't visit individual tutorial pages if marked as classroom" do
      tutorial = create(:tutorial, classroom: true)

      video1 = create(:video, tutorial_id: tutorial.id)
      video2 = create(:video, tutorial_id: tutorial.id)

      visit tutorial_path(tutorial)

      expect(current_path).to eq('/')
      expect(page).to have_content('You are not authorized to view that tutorial. Please Signup or Login to view it.')
    end
  end
end
