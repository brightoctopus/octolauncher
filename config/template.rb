apply 'config/application.rb'
remove_file 'config/secrets.yml'

gsub_file 'config/routes.rb', /  # root 'welcome#index'/ do
  #  root 'home#index'#
end

copy_file 'config/meta.yml'
copy_file 'config/initializers/default_meta.rb'
copy_file 'config/initializers/generators.rb'

apply 'config/environments/development.rb'

route "root 'home#index'"

if @default_options[:sidekiq]
  copy_file 'config/sidekiq.yml'
  route %Q(mount Sidekiq::Web => '/sidekiq' # Unsafe for production, should only be accessible to admins\n)
end