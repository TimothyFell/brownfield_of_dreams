class UserDashboardFacade

  def initialize(user)
    @user = user
  end

  def github_repos(quantity)
    get_repos_result[0...quantity].map do |repo_data|
      Github::Repository.new(repo_data)
    end
  end

  def github_followers
    get_followers_result.map do |follower_data|
      Github::Follower.new(follower_data)
    end
  end

  def github_following
    get_following_result.map do |following_data|
      Github::Following.new(following_data)
    end
  end

  def friends
    @user.friends(@user.id)
  end

  def friends?(github_user_id)
    @user.friended_users.include?(User.find_by(guid: github_user_id))
  end

  def user_exists?(github_user_id)
    User.find_by(guid: github_user_id)
  end

  def bookmarked_tutorial_videos
    @user.bookmark_hash(@user.id)
  end

  private

  def get_repos_result
    @_get_repos_result ||= github_service.get_repos_json
  end

  def get_followers_result
    @_get_followers_result ||= github_service.get_followers_json
  end

  def get_following_result
    @_get_following_result ||= github_service.get_following_json
  end

  def github_service
    GithubService.new(@user.token)
  end

end
