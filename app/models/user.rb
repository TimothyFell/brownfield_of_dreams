class User < ApplicationRecord
  has_many :user_videos
  has_many :videos, through: :user_videos

  has_many :friendships
  has_many :friended_users, through: :friendships

  validates :email, uniqueness: true, presence: true
  validates_presence_of :password, on: :create
  validates :password, presence: true, allow_blank: true, on: :update
  validates_presence_of :first_name
  enum role: [:default, :admin]
  has_secure_password

  def friends(current_user_id)
    friended_user_ids = User.joins(:friendships).where(friendships: {user_id: current_user_id}).pluck(:friended_user_id)

    friended_user_ids.map do |friended_user_id|
      User.find(friended_user_id)
    end
  end

  def name
    "#{first_name} #{last_name}"
  end
end
