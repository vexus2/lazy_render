class LazyRenderController < LazyRender::LazyloadController
  def pc__pickup_ads(locals)
    @data[:pickup_ads] = 1
  end

  def load
    super
    # self.class.superclass.instance_method(:load).bind(self).call
  end
end
