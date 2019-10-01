
require 'rake'
require 'active_record'
require 'bundler'
Bundler.require

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
require_all 'lib'

require 'bundler/setup'
require 'sinatra/activerecord'

Dir[File.join(File.dirname(__FILE__), '../app/models', '*.rb')].each { |f| require f }
connection_details = YAML.safe_load(File.open('config/database.yml'))
ActiveRecord::Base.establish_connection(connection_details)
# uncomment line 23 and comment out line 22 in order to show all of the
# SQL queries that Active Record handles.
ActiveRecord::Base.logger = nil
# ActiveRecord::Base.logger = Logger.new(STDOUT)
require_all 'app'






