class UserDashboardFacade

  def initialize(user)
    @user = user
  end

  def github_repos(quantity)
    # if @user.token
      get_repos_result[0...quantity].map do |repo_data|
        Github::Repository.new(repo_data)
      end
    # end
  end

  private

  def get_repos_result
    @_get_repos_result ||= github_service.get_repos_json
  end

  def github_service
    GithubService.new(@user.token)
  end

end
