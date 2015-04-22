require_dependency 'lazy_render/application_controller'

module LazyRender
  class LazyloadController < ApplicationController
    protect_from_forgery with: :null_session

    def load
      return unless params['lazy_renders']
      result = []
      @data  = {}
      params['lazy_renders'].values.select { |v| v['name'] && respond_to?(v['name']) }.each do |v|
        data = {
            name:   v['name'],
            locals: v['locals'] || {}
        }
        data[:locals].empty? ? send(data[:name]) : send(data[:name], data[:locals])
        # TODO: Add Benchmark time
        html = render_to_string 'lazy_render/' + data[:name].gsub('__', '/'), layout: false, locals: { data: @data || {} }
        result << html
      end

      render json: result
    end
  end
end
