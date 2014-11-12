class LazyRenderController < LazyRender::LazyloadController
  def lazy_render_message
  end

  def pass_variables(locals)
    @data[:value1] = 'value1'
    @data[:value2] = { key: 'value2' }
    @data[:value3] = locals[:v]
  end

  def directory__separator
  end

  def with_cache
  end

  def load
    super
  end
end
