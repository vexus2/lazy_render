require 'spec_helper'

describe 'LazyRender', :type => :feature, js: true do
  before { visit root_path; sleep 1 }
  describe 'is show lazy_render messages after secs' do
    it { expect(page).to have_content('LazyRender Message') }
    it { expect(page).to have_content('value1') }
    it { expect(page).to have_content('value2') }
    it { expect(page).to have_content('sample text') }
    it { expect(page).to have_content('Separated by the directory') }
  end
end