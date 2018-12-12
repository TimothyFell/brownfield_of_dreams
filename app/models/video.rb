class Video < ApplicationRecord
  has_many :user_videos
  has_many :users, through: :user_videos
  belongs_to :tutorial

  validates :position, presence: true

  def self.assign_position_from_zero
    zero_position_videos = joins(:tutorial).where(position: 0)
    zero_position_videos.each do |video|
      highest_position = video.tutorial.videos.length
      video.position = highest_position
      video.save!
    end
  end

  def self.assign_position_from_nil
    zero_position_videos = joins(:tutorial).where(position: nil)
    zero_position_videos.each do |video|
      highest_position = video.tutorial.videos.length
      video.position = highest_position
      video.save!
    end
  end
end
