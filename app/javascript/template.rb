copy_file 'app/javascript/stylesheets/application.scss'
copy_file 'app/javascript/stylesheets/base/_fonts.scss'
copy_file 'app/javascript/stylesheets/base/_index.scss'
copy_file 'app/javascript/stylesheets/base/_resets.scss'
copy_file 'app/javascript/stylesheets/base/_typography.scss'
copy_file 'app/javascript/stylesheets/base/_utilities.scss'
copy_file 'app/javascript/stylesheets/components/_alerts.scss'
copy_file 'app/javascript/stylesheets/components/_avatars.scss'
copy_file 'app/javascript/stylesheets/components/_index.scss'
copy_file 'app/javascript/stylesheets/components/_navbar.scss'
copy_file 'app/javascript/stylesheets/config/tailwind.config.js'
copy_file 'app/javascript/stylesheets/pages/_index.scss'

copy_file 'postcss.config.js', force: true

prepend_file 'app/javascript/packs/application.js', "import 'stylesheets/application.scss';"

add_packages

def add_packages
  packages = %w[
    tailwindcss
  ]
  run_with_clean_bundler_env "yarn add #{packages.join(' ')}"
end