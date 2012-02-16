# encoding: utf-8

$:.push File.expand_path("../lib", __FILE__)
require "beggar/version"

Gem::Specification.new do |s|
  s.name        = "beggar"
  s.version     = Beggar::VERSION
  s.authors     = ["Bartlomiej Kozal"]
  s.email       = ["bkzl@me.com"]
  s.homepage    = "https://github.com/bkzl/beggar"
  s.summary     = %q{Tool for generating time reports from Basecamp}
  s.description = %q{Tool for generating time reports from Basecamp. You can specify rate for each project and get value of your month salary.}

  s.rubyforge_project = "beggar"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_development_dependency "rspec", ">= 2.7.0"
  s.add_dependency "httparty"
end
