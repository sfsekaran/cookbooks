##
# TopSpin Vagrant Recipe
##

# update all libs
execute "apt-get-update" do
  command "apt-get update"
end

# for memcache gem
package 'libsasl2-2'
package 'libsasl2-dev'

# install bundled gems
gem_package 'bundler'
execute 'bundle install' do
  command 'bundle install'
  cwd '/vagrant/manager'
end

# install a database.local.yml
cookbook_file '/vagrant/manager/config/database.local.yml'

execute 'bundle exec rake db:create' do
  cwd '/vagrant/manager'
  not_if 'mysql --batch --skip-column-names -e "SHOW DATABASES LIKE \'topspin_production\'" | grep topspin_production'
end

# run migrations
execute 'bundle exec rake db:migrate' do
  cwd '/vagrant/manager'
end

# TODO: run seeds

# TODO: requie passenger + nginx in here, not in Vagrantfile
# require_package 'passenger_nginx'

# add to nginx config
cookbook_file '/etc/nginx/sites-enabled/topspin.conf' do
  source 'nginx.conf'
end
service 'nginx' do
  action :restart
end
