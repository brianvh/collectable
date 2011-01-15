# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "collectable/version"

Gem::Specification.new do |s|
  s.name        = "collectable"
  s.version     = Collectable::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Brian V. hughes"]
  s.email       = ["brianvh@dartmouth.edu"]
  s.homepage    = ""
  s.summary     = "#{s.name}-#{s.version}"
  s.description = %q{Provide an easy way for a parent class to collect its subclasses.}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'i18n', '~> 0.5.0'
  s.add_dependency 'activesupport', '~> 3.0.0'

  s.add_development_dependency 'bundler', '~> 1.0.7'
  s.add_development_dependency 'rspec', '~> 2.4.0'
end
