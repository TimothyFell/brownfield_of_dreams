class GithubService

  def initialize(user_token)
    @user_token = user_token
  end

  def get_repos_json
    get_json("/user/repos")
  end

  private

  def get_json(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: "https://api.github.com") do |f|
      f.headers['Authorization'] = @user_token
      f.adapter  Faraday.default_adapter
    end
  end
end
