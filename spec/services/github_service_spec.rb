require 'rails_helper'

describe 'GithubService' do
  it 'exists' do
    service = GithubService.new

    expect(service).to be_a(GithubService)
  end

  context 'instance methods' do
    context '#get_repos_json' do
      it 'returns an array of hashes' do
        VCR.use_cassette("github_service_spec") do
          service = GithubService.new
          expect(service.get_repos_json).to be_a(Array)
          expect(service.get_repos_json[0]).to have_key(:name)
          expect(service.get_repos_json[0]).to have_key(:html_url)
        end
      end
    end
  end
end
