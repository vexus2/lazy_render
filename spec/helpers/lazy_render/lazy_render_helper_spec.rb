require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the LazyloadHelper. For example:
#
# describe LazyloadHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
module LazyRender
  RSpec.describe LazyloadHelper, :type => :helper do

    describe '#lazy_render' do
      it 'return span tag with class and name' do
        expect(helper.lazy_render('sample_class')).to eq "<span class=\"js-lazy-render-sample_class\" data-lazy-render-name=\"sample_class\"></span>"
        expect(helper.lazy_render('sample_class', locals: [])).to eq "<span class=\"js-lazy-render-sample_class\" data-lazy-render-name=\"sample_class\"></span>"
        expect(helper.lazy_render('sample_class', locals: 'Sample')).to eq "<span class=\"js-lazy-render-sample_class\" data-lazy-render-name=\"sample_class\"></span>"
      end
      it 'return span tag with class and name and locals' do
        expect(helper.lazy_render('sample_class', locals: { var1: 'var3', var2: 'var4' })).to eq "<span class=\"js-lazy-render-sample_class\" data-lazy-render-name=\"sample_class\" data-lazy-render-params=\"{&quot;var1&quot;:&quot;var3&quot;,&quot;var2&quot;:&quot;var4&quot;}\"></span>"
      end

      it 'return span tag with class and name and cache params' do
        expect(helper.lazy_render('sample_class', cache: 200)).to eq "<span class=\"js-lazy-render-sample_class\" data-lazy-render-cache=\"200\" data-lazy-render-name=\"sample_class\"></span>"
        expect(helper.lazy_render('sample_class', cache: '300')).to eq "<span class=\"js-lazy-render-sample_class\" data-lazy-render-cache=\"300\" data-lazy-render-name=\"sample_class\"></span>"
        expect(helper.lazy_render('sample_class', cache: 'abc')).to eq "<span class=\"js-lazy-render-sample_class\" data-lazy-render-cache=\"0\" data-lazy-render-name=\"sample_class\"></span>"
      end

      it 'return span tag with class and name and callback method' do
        expect(helper.lazy_render('sample_class', callback: 'Activity.start')).to eq "<span class=\"js-lazy-render-sample_class\" data-lazy-render-callback=\"Activity.start\" data-lazy-render-name=\"sample_class\"></span>"
      end
    end
  end
end
