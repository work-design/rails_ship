$:.push File.expand_path('lib', __dir__)
require 'rails_ship/version'

Gem::Specification.new do |s|
  s.name = 'rails_ship'
  s.version = RailsShip::VERSION
  s.authors = ['qinmingyuan']
  s.email = ['mingyuan0715@foxmail.com']
  s.homepage = 'https://github.com/work-design/rails_ship'
  s.summary = ' Summary of RailsShip.'
  s.description = ' Description of RailsShip.'
  s.license = 'LGPL-3.0'

  s.files = Dir[
    '{app,config,db,lib}/**/*',
    'LICENSE',
    'Rakefile',
    'README.md'
  ]

  s.add_dependency 'rails', '~> 5.2.1'

  s.add_development_dependency 'sqlite3'
end
