class InviteService

  def initialize(handle, token)
    @handle = handle
    @token = token
  end

  def get_user_json
    get_json("/users/#{@handle}")
  end

  private

  def get_json(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: "https://api.github.com") do |f|
      f.headers['Authorization'] = @token
      f.adapter  Faraday.default_adapter
    end
  end

end
