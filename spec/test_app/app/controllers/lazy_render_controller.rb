class LazyRenderController < LazyRender::LazyloadController
  def lazy_render_message(locals)
  end

  def pass_variables(locals)
    @data[:value1] = 'value1'
    @data[:value2] = { key: 'value2' }
    @data[:value3] = locals[:v]
  end

  def directory__separator(locals)
  end

  def with_cache(locals)
  end

  def load
    super
  end
end
