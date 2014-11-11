require_dependency "lazy_render/application_controller"

module LazyRender
  class LazyloadController < ApplicationController
    protect_from_forgery with: :null_session

    def load
      return unless params['lazy_renders']
      result = []
      @data = {}
      params['lazy_renders'].values.each do |v|
        next unless v['name']
        data = {
            name:   v['name'],
            locals: v['locals'] || {}
        }
        send(data[:name], data[:locals])
        # TODO: Add Benchmark time
        html = render_to_string 'lazy_render/' + data[:name].gsub('__', '/'), layout: false, locals: { data: @data || {} }
        result << html
      end

      render json: result
    end

    def pc__pickup_ads(locals)
      @data[:pickup_ads] = 1
    end
  end
end
