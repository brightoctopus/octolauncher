# Octolauncher Rails Template 🐙🚀

Generate a new rails app with optional default [Bright Octopus](https://www.brightoctopus.dev) configurations using this [Rails Template](http://guides.rubyonrails.org/rails_application_templates.html).

## Getting started

### Requirements 🔧

You need to the following dependencies:

* Ruby 2.5 or higher
* bundler - `gem install bundler`
* rails 6 - `gem install rails`
* Yarn - `brew install yarn` or [Install Yarn](https://yarnpkg.com/en/docs/install)

### Use 💻

```bash
rails new myapp -d postgresql -m https://raw.githubusercontent.com/brightoctopus/octolauncher/master/template.rb
```

or `git clone git@github.com:brightoctopus/octolauncher.git` and use it locally:

```bash
rails new myapp -d postgresql -m template.rb
```

### Included 📦

After you run `Rails new`, you can chose to create the new app with the default configurations or opt out of 1 or more of the following:

* Devise
* Tailwind CSS
* Sidekiq
* Rspec
* Bullet
* Mailcatcher

### Devise 👩🏾‍💻

Creates a `User` model with a `first_name` and a `last_name` and adds a navbar with the sign in/sign up/sign out links, plus an avatar with a dropdown.

### Tailwind CSS 🎨

Includes out of the box all of the necessary setup to get started using [Tailwind CSS](https://tailwindcss.com/).

### Sidekiq 👩‍🎤

Setup up [Sidekiq](https://github.com/mperham/sidekiq) and redis for background job processing.

### RSpec 🔧

Installs [RSpec](https://github.com/rspec/rspec-rails) for testing and brakeman and bundle_autdit for static analysis. It also includes some opinionated configurations and helpers which are autoloaded in `spec/support`.

It also installs:

* Capybara
* Selenium-webdriver and Webdrivers
* Factory Bot
* Rails Controller Testing
* Rspec Collection Matchers
* Shoulda Matcher
* Simplecov

### Bullet 🚨

Configures [Bullet](https://github.com/flyerhzm/bullet) to watch N+1 queries in development.

### Mailcatcher 📬

Installs the [Mailcatcher](https://github.com/sj26/mailcatcher) gem locally to receive mailers in development.

Run `mailcatcher` from the terminal to start an SMTP server in your machine and open http://127.0.0.1:1080 in the browser for a cool inbox view.

### Other 🛠

Adds a layout helper for the title which automatically assigns meta tags as well:

```erb
<h1><%= title content: 'Home' %></h1>
```

This will piped through the meta_tags helper which will use the title and the product name to create the respective meta tag.

It is possible to set the title without the product name:

```erb
<h1><%= title content: 'Home', product_name: false %></h1>
```

The meta_tags get their default configuration from `config/meta.yml`.