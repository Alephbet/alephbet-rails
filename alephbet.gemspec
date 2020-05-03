$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "alephbet/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "alephbet"
  spec.version     = Alephbet::VERSION
  spec.authors     = ["Yoav Aner"]
  spec.email       = [""]
  spec.homepage    = "https://github.com/alephbet/alephbet-rails"
  spec.summary     = "Alephbet A/B testing backend for Rails"
  spec.description = "https://github.com/alephbet/alephbet-rails"
  spec.license     = "MIT"

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "rails", "~> 6.0.2", ">= 6.0.2.2"

  spec.add_development_dependency "sqlite3"
end
