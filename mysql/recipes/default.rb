# for mysql gem
package 'mysql-server'
package 'mysql-client'
package 'libmysqlclient-dev'

service 'mysql' do
  action [:enable, :start]
end
