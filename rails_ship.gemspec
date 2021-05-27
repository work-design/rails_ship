$:.push File.expand_path('lib', __dir__)
require 'rails_ship/version'

Gem::Specification.new do |s|
  s.name = 'rails_ship'
  s.version = RailsShip::VERSION
  s.authors = ['qinmingyuan']
  s.email = ['mingyuan0715@foxmail.com']
  s.homepage = 'https://github.com/work-design/rails_ship'
  s.summary = 'Ship logic'
  s.description = '运输解决方案'
  s.license = 'MIT'

  s.files = Dir[
    '{app,config,db,lib}/**/*',
    'LICENSE',
    'Rakefile',
    'README.md'
  ]

  s.add_dependency 'rails_com', '~> 1.2'
  s.add_dependency 'rails_trade'
end
