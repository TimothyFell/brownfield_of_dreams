class Github::Repository
  attr_reader :name,
              :url,
              :id

  def initialize(args)
    @name = args[:name]
    @url = args[:html_url]
    @id = args[:id]
  end
end
