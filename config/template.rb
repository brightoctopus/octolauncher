remove_file 'config/secrets.yml'

gsub_file 'config/routes.rb', /  # root 'welcome#index'/ do
  #  root 'home#index'#
end

copy_file 'config/meta.yml'
copy_file 'config/initializers/default_meta.rb'
copy_file 'config/initializers/generators.rb'

route "root 'home#index'"