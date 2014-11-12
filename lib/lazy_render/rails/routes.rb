require 'active_support/core_ext/object/try'
require 'active_support/core_ext/hash/slice'

module ActionDispatch::Routing
  class Mapper
    def lazy_render_for(path, *block)
      options = block.extract_options!
      match "#{path}", to: "#{options[:to]}#load", via: 'post'
    end
  end
end
