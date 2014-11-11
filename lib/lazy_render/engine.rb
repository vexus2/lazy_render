module LazyRender
  class Engine < ::Rails::Engine
    isolate_namespace LazyRender

    initializer 'lazy_render.lazyload_controller' do |app|
       ActiveSupport.on_load :lazyload_controller do
         helper LazyRender::LazyloadHelper
       end
    end

    config.generators do |g|
      g.test_framework :rspec
      g.fixture_replacement :factory_girl, :dir => 'spec/factories'
    end
  end
end
