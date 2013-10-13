# in app.rb
Shoes.setup do
  require 'active_record'
  require 'activerecord-jdbcmysql-adapter'
  require 'fileutils'


  ActiveRecord::Base.establish_connection(
     :adapter  => "mysql",
     :host     => "localhost",
     :encoding => "utf8",
     :username => "root",
     :password => "root",
     :database => "project_17_development"
   )

end