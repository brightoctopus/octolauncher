require 'bundler'
require 'json'
require 'fileutils'
require 'shellwords'

RAILS_REQUIREMENT = '~> 6.0.0'.freeze

# Copied from: https://github.com/mattbrictson/rails-template
# Add this template directory to source_paths so that Thor actions like
# copy_file and template resolve against our source files. If this file was
# invoked remotely via HTTP, that means the files are not present locally.
# In that case, use `git clone` to download them to a local temporary dir.
def add_template_repository_to_source_path
  if __FILE__ =~ %r{\Ahttps?://}
    require 'tmpdir'
    source_paths.unshift(tempdir = Dir.mktmpdir('rails-templates'))
    at_exit { FileUtils.remove_entry(tempdir) }
    git clone: [
      '--quiet',
      'https://github.com/brightoctopus/rails-templates.git',
      tempdir
    ].map(&:shellescape).join(' ')

    if (branch = __FILE__[%r{rails-templates/(.+)/template.rb}, 1])
      Dir.chdir(tempdir) { git checkout: branch }
    end
  else
    source_paths.unshift(File.dirname(__FILE__))
  end
end

def assert_minimum_rails_version
  requirement = Gem::Requirement.new(RAILS_REQUIREMENT)
  rails_version = Gem::Version.new(Rails::VERSION::STRING)
  return if requirement.satisfied_by?(rails_version)

  prompt = "This template requires Rails #{RAILS_REQUIREMENT}. "\
           "You are using #{rails_version}. Continue anyway?"
  exit 1 if no?(prompt)
end

def preexisting_git_repo?
  @preexisting_git_repo ||= (File.exist?(".git") || :nope)
  @preexisting_git_repo == true
end

def run_with_clean_bundler_env(cmd)
  success = if defined?(Bundler)
              Bundler.with_clean_env { run(cmd) }
            else
              run(cmd)
            end
  unless success
    puts "Command failed, exiting: #{cmd}"
    exit(1)
  end
end

def run_rubocop_autocorrections
  run 'rubocop -a > /dev/null || true'
  # run_with_clean_bundler_env 'bin/rubocop -a --fail-level A > /dev/null || true'
end

def set_default_options
  @default_options = {
    devise: true,
    tailwind: true,
    sidekiq: true,
    rspec: true,
    mailcatcher: true
  }
end

def ask_options
  return unless no?('Use default configuration? (Y/n)', :blue)

  @default_options[:devise] = yes?('Install Devise? (Y/n)')
  @default_options[:tailwind] = yes?('Install TailwindCSS? (Y/n)')
  @default_options[:sidekiq] = yes?('Install Sidekiq? (Y/n)')
  @default_options[:rspec] = yes?('Install RSpec? (Y/n)')
  @default_options[:mailcatcher] = yes?('Install Mailcatcher? (Y/n)')
end

def add_gems
  template 'Gemfile.tt', force: true
end

def add_rspec
  return unless @default_options[:rspec]

  generate 'rspec:install'

  directory 'spec', force: true
end

def add_devise
  return unless @default_options[:devise]

  generate 'devise:install'

  generate 'devise', 'User',
           'first_name',
           'last_name'
end

def stop_spring
  run 'spring stop'
end

def add_tailwind
  return unless @default_options[:tailwind]

  apply 'app/javascript/template.rb'
end

def install_mailcatcher
  return unless @default_options[:tailwind]

  return if run 'gem list -i "^mailcatcher$"'

  run 'gem install mailcatcher'
end

def copy_templates
  template 'README.md.tt', force: true
  remove_file 'README.rdoc'

  template 'env.tt'
  copy_file 'gitignore', '.gitignore', force: true
  template 'ruby-version.tt', '.ruby-version', force: true

  copy_file 'Procfile'

  apply 'app/template.rb'
  apply 'config/template.rb'

  template 'rubocop.yml.tt', '.rubocop.yml'
end

def apply_template!
  assert_minimum_rails_version
  add_template_repository_to_source_path

  set_default_options
  ask_options

  add_gems

  after_bundle do
    stop_spring
    add_rspec
    add_devise
    add_tailwind
    install_mailcatcher

    copy_templates

    rails_command 'db:drop db:create db:migrate'

    generate_spring_binstubs

    binstubs = %w[bundler rubocop]
    run_with_clean_bundler_env "bundle binstubs #{binstubs.join(' ')} --force"

    run_rubocop_autocorrections

    git :init unless preexisting_git_repo?

    git add: '-A .'
    git commit: "-n -m 'Set up project'"
  end
end

apply_template!