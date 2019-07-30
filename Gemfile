source "https://rubygems.org"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


# Bundle edge Rails instead: gem "rails", github: "rails/rails"
gem "rails", "~> 5.1.4"
# Use mysql as the database for Active Record
gem "mysql2", ">= 0.3.18", "< 0.5"
# Use Puma as the app server
gem "puma", "~> 3.7"
# Use SCSS for stylesheets
gem "sass-rails", "~> 5.0"
gem "uglifier", ">= 1.3.0"
gem "coffee-rails", "~> 4.2"
gem "turbolinks", "~> 5"
gem "jbuilder", "~> 2.5"
gem "devise"
gem "rails_admin", "~> 1.3"
gem "bootstrap-sass"
gem "jquery-rails"
gem "paperclip", "~> 6.0.0"
gem "slim-rails"

group :development, :test do
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
  gem "capybara", "~> 2.13"
  gem "selenium-webdriver"
  gem "rubocop", require: false
  gem "pry-rails"
end

group :development do
  gem "web-console", ">= 3.3.0"
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem "figaro"

group :staging, :production do
  gem "capistrano", "~> 3.7"
  gem "capistrano-bundler"
  gem "capistrano-rails"
  gem "capistrano-rvm"
  gem "capistrano3-puma"
end
