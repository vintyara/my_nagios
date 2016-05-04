$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "my_nagios/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "my_nagios"
  s.version     = MyNagios::VERSION
  s.authors     = ["Vitaly Omelchenko"]
  s.email       = ["prosto.vint@gmail.com"]
  s.homepage    = "TODO"
  s.summary     = "Simple monitoring"
  s.description = "Simple monitoring based on Nagios scripts"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.6"
  s.add_dependency "haml"
  s.add_dependency "sidekiq"
  s.add_dependency "sidekiq-cron"
  s.add_dependency "sinatra"
  s.add_dependency "net-ssh"
  s.add_dependency "bootstrap-sass"
  s.add_dependency "mysql2"
  s.add_dependency "coffee-rails"

  s.add_development_dependency "sqlite3"
end
