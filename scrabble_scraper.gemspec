# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'scrabble_scraper/version'

Gem::Specification.new do |spec|
  spec.name          = "scrabble_scraper"
  spec.version       = ScrabbleScraper::VERSION
  spec.authors       = ["Thomas Brus"]
  spec.email         = ["thomas.brus@me.com"]
  spec.summary       = %q{Fetches scrabble games from the Internet Scrabble Club.}
  spec.homepage      = "https://github.com/thomasbrus/scrabble-scraper"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"

  spec.add_dependency "celluloid-io"
  spec.add_dependency "parslet"
  spec.add_dependency "mongo_mapper"
  spec.add_dependency "bson_ext"
end
