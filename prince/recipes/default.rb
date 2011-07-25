package 'libtiff4'
package 'libgif4'
package 'libfontconfig1'

execute 'download princexml' do
  user 'root'
  command 'wget http://www.princexml.com/download/prince_7.2-4ubuntu10.04_i386.deb'
  cwd '/tmp'
  not_if 'dpkg --list | grep prince'
end
execute 'install princexml' do
  command 'dpkg -i prince_7.2-4ubuntu10.04_i386.deb'
  user 'root'
  cwd '/tmp'
  not_if 'dpkg --list | grep prince'
end
