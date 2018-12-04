class UserDashboardFacade

  def github_repos(quantity)
    get_repos_result[0...quantity].map do |repo_data|
      Github::Repository.new(repo_data)
    end
  end

  private

  def get_repos_result
    @_get_repos_result ||= github_service.get_repos_json
  end

  def github_service
    GithubService.new
  end
end
