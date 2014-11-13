$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "lazy_render/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "lazy_render"
  s.version     = LazyRender::VERSION
  s.authors     = ["vexus2"]
  s.email       = ["hikaru.tooyama@gmail.com"]
  s.homepage    = "http://github.com/vexus2"
  s.summary     = "Delay load your actions"
  s.description = "It delays loading of partial or actions in views."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", ">= 4.0.0"
  s.add_dependency "jquery-rails"

  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'capybara'
  s.add_development_dependency 'capybara-webkit'
  s.add_development_dependency 'factory_girl_rails'
end
