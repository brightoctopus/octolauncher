copy_file 'app/assets/stylesheets/application.scss'
remove_file 'app/assets/stylesheets/application.css'

copy_file 'app/assets/images/logo.png'

copy_file 'app/controllers/home_controller.rb'
copy_file 'app/helpers/layout_helper.rb'
copy_file 'app/helpers/meta_tags_helper.rb'
copy_file 'app/views/layouts/application.html.erb', force: true
copy_file 'app/views/layouts/_meta-tags.html.erb'
copy_file 'app/views/shared/_flashes.html.erb'
copy_file 'app/views/shared/_footer.html.erb'
copy_file 'app/views/shared/_navbar.html.erb'
copy_file 'app/views/home/index.html.erb'