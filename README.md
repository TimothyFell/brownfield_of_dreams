# Brownfield Of Dreams

This is a repo for Brownfield Project for Mod 3 of Turing

### About the Project

This Application is built off of a brownfield project from a previous student.  

This is a Ruby on Rails application used to organize YouTube content used for online learning. Each tutorial is a playlist of video segments. Within the application an admin is able to create tags for each tutorial in the database. A visitor or registered user can then filter tutorials based on these tags.

A visitor is able to see all of the content on the application but in order to bookmark a segment they will need to register. Once registered a user can bookmark any of the segments in a tutorial page.

Our tasks involved consuming GitHub's API to list followers and followings, build friendships based those GitHub relationships, fix various bugs, and build email functionality.

## Local Setup
### Initial Setup

Clone down the repo
```
$ git clone
```

Install the gem packages
```
$ bundle install
```

Install node packages for stimulus
```
$ brew install node
$ brew install yarn
$ yarn add stimulus
```

Set up the database
```
$ bundle exec rake db:create
$ bundle exec rake db:migrate
$ bundle exec rake db:seed
```

### API Setup

We need to run Figaro to create a hidden .yml file to store our API keys locally

```
$ bundle exec figaro install
```
Within config/applicatoin.yml, add the following keys:

SENDGRID_USERNAME: <Heroku SendGrid Add-on Generated Username>

SENDGRID_PASSWORD: <Heroku SendGrid Add-on Generated Password>

GITHUB_KEY: <GitHub OAuth client_id>

GITHUB_SECRET: <GitHub OAuth secret>

GITHUB_API_KEY_1: <GitHub Personal Access Token>

YOUTUBE_API_KEY: <YouTube Access Token>

Visit the following the links to find the above information:

* https://devcenter.heroku.com/articles/sendgrid
* https://github.com/omniauth/omniauth-github
* https://developer.github.com/v3/
* https://developers.google.com/youtube/v3/getting-started

Run the test suite:
```ruby
$ bundle exec rspec
```

## Technologies
* [Stimulus](https://github.com/stimulusjs/stimulus)
* [will_paginate](https://github.com/mislav/will_paginate)
* [acts-as-taggable-on](https://github.com/mbleigh/acts-as-taggable-on)
* [webpacker](https://github.com/rails/webpacker)
* [vcr](https://github.com/vcr/vcr)
* [selenium-webdriver](https://www.seleniumhq.org/docs/03_webdriver.jsp)
* [chromedriver-helper](http://chromedriver.chromium.org/)
* [figaro](https://github.com/laserlemon/figaro)
* [MailCatcher](https://mailcatcher.me/) (For viewing sent emails in Test Environment)
* [capybara-email](https://github.com/DavyJonesLocker/capybara-email) (For testing email content)

### Versions
* Ruby 2.4.1
* Rails 5.2.1
