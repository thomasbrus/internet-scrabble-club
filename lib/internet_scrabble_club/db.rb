# TODO: Remove all this, create internet-scrabble-club-scraper?

require 'data_mapper'

require 'dm-postgres-adapter'
require 'dm-validations'

DataMapper.setup(:default, 'postgres://localhost/internet_scrabble_club')
DataMapper::Model.raise_on_save_failure = true

require_relative 'models'

DataMapper.finalize
DataMapper.auto_upgrade!
