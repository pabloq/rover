# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "rover/version"

Gem::Specification.new do |s|
  s.name        = "rover"
  s.version     = Rover::VERSION
  s.authors     = ["Pablo Q."]
  s.email       = ["paqs140482@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{ZenCash test}
  s.description = %q{ZenCash test}

  s.rubyforge_project = "rover"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_development_dependency "rspec"
  s.add_development_dependency 'rake'
end