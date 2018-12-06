class Github::Following
  attr_reader :name,
              :url,
              :id

  def initialize(args)
    @name = args[:login]
    @url = args[:html_url]
    @id = args[:id]
  end
end
