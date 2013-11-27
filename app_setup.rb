Shoes.setup do
  require 'active_record'
  require 'activerecord-jdbcmysql-adapter'
  require 'fileutils'
  ActiveRecord::Base.establish_connection YAML.load(File.read(File.expand_path('../config/database.yml', __FILE__)))
end
