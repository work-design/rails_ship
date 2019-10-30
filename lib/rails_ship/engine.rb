module RailsShip
  class Engine < ::Rails::Engine

    config.generators do |g|
      g.rails = {
        assets: false,
        stylesheets: false,
        helper: false
      }
      g.test_unit = {
        fixture: true,
        fixture_replacement: :factory_girl
      }
    end

    initializer 'rails_ship.assets.precompile' do |app|
      app.config.assets.precompile += ['rails_ship_manifest.js']
    end

  end
end
