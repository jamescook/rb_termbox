# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'termbox/version'

Gem::Specification.new do |s|
  s.name        = "termbox"
  s.version     = Termbox::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["James Cook, Paul Schuegraf"]
  s.email       = ["jamecook@gmail.com, paul@verticallabs.ca"]
  s.summary     = %q{Ruby binding to Termbox, a ncurses alternative.}
  #s.description = %q{}

  s.required_rubygems_version = ">= 1.3.6"
  s.rubyforge_project         = "rb_termbox"

  s.add_dependency "ffi", '>= 1.0.8'
  s.add_development_dependency "rspec"

  s.files              = `git ls-files`.split("\n")
  s.test_files         = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths      = ["lib"]
end
