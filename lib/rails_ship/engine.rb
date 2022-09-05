require 'rails_com'

module RailsShip
  class Engine < ::Rails::Engine

    config.autoload_paths += Dir[
      "#{config.root}/app/models/box_host",
      "#{config.root}/app/models/box_entrust"
    ]
    config.eager_load_paths += Dir[
      "#{config.root}/app/models/box_host",
      "#{config.root}/app/models/box_entrust"
    ]

    config.generators do |g|
      g.rails = {
        assets: false,
        stylesheets: false
      }
      g.helper false
      g.resource_route false
      g.test_unit = {
        fixture: true,
        fixture_replacement: :factory_girl
      }
      g.templates.unshift File.expand_path('lib/templates', RailsCom::Engine.root)
    end

  end
end
