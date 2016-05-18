module LazyRender
  module LazyloadHelper
    def lazy_render(name, locals: {}, cache: false, callback: false, parallel: false)
      data = { 'lazy-render-name' => name }
      data['lazy-render-params'] = locals if locals.instance_of?(Hash) && locals.presence
      data['lazy-render-cache'] = cache.to_i if cache
      data['lazy-render-callback'] = callback if callback
      data['lazy-render-parallel'] = parallel if parallel
      content_tag :span, nil, class: "js-lazy-render-#{name}", data: data
    end
  end
end
