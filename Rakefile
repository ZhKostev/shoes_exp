require "active_record"
require "active_support"
require "require_all"

require_all "app/models"

include ActiveRecord::Tasks

database_configuration = YAML.load(File.read('config/database.yml'))

namespace :database do

  desc "Create a database with tables."
  task :create do
    DatabaseTasks.create database_configuration

    ActiveRecord::Base.establish_connection database_configuration

    ActiveRecord::Base.connection.create_table(:articles) do |t|
      t.string :title
      t.text :body
    end
  end

  desc "Drop a database."
  task :drop do
    DatabaseTasks.drop database_configuration
  end

end