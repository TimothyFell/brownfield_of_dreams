require 'rails_helper'

describe 'GithubService' do
  it 'exists' do
    user = create(:user, token: ENV['GITHUB_API_KEY_1'])
    service = GithubService.new(user.token)

    expect(service).to be_a(GithubService)
  end

  context 'instance methods' do
    context '#get_repos_json' do
      it 'returns an array of hashes' do
        VCR.use_cassette("github_service_repos_spec") do
          user = create(:user, token: ENV['GITHUB_API_KEY_1'])
          service = GithubService.new(user.token)
          expect(service.get_repos_json).to be_a(Array)
          expect(service.get_repos_json[0]).to have_key(:name)
          expect(service.get_repos_json[0]).to have_key(:html_url)
        end
      end
    end

    context '#get_followers_json' do
      it 'returns an array of hashes' do
        VCR.use_cassette("github_service_followers_spec") do
          user = create(:user, token: ENV['GITHUB_API_KEY_1'])
          service = GithubService.new(user.token)
          expect(service.get_followers_json).to be_a(Array)
          expect(service.get_followers_json[0]).to have_key(:login)
          expect(service.get_followers_json[0]).to have_key(:html_url)
        end
      end
    end

    context '#get_following_json' do
      it 'returns an array of hashes' do
        VCR.use_cassette("github_service_following_spec") do
          user = create(:user, token: ENV['GITHUB_API_KEY_1'])
          service = GithubService.new(user.token)
          expect(service.get_followers_json).to be_a(Array)
          expect(service.get_followers_json[0]).to have_key(:login)
          expect(service.get_followers_json[0]).to have_key(:html_url)
        end
      end
    end

  end
end
