require 'rails_helper'

RSpec.describe Video, type: :model do

  describe 'Validations' do
    it { should validate_presence_of :position}
  end

  describe 'Relationships' do
    it { should have_many :user_videos }
    it { should have_many :users }
    it { should belong_to :tutorial }
  end

  describe 'assign_position_from_zero' do
    it 'should change all video position videos to not be 0' do
      tutorial = create(:tutorial)
      video = tutorial.videos.create({
        "title"=>"SOME STUFF",
        "description"=> Faker::Hipster.paragraph(2, true),
        "video_id"=>"12345678",
        "thumbnail"=>"https://i.ytimg.com/vi/qMkRHW9zE1c/hqdefault.jpg"
        })

      expect(video.position).to eq(0)

      Video.assign_position_from_zero

      video.reload

      expect(video.position).to eq(1)
    end
  end

  describe 'assign_position_from_nil' do
    it 'should change all video position videos to not be nil' do
      tutorial = create(:tutorial)
      video = create(:video, position: nil)

      expect(video.position).to eq(nil)

      Video.assign_position_from_nil

      video.reload

      expect(video.position).to eq(1)
    end
  end

end
