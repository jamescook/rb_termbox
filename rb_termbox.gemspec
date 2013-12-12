# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'termbox/version'

Gem::Specification.new do |s|
  s.name        = "rb_termbox"
  s.version     = Termbox::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["James Cook"]
  s.email       = ["jcook.rubyist@gmail.com"]
  s.summary     = s.description = %q{Ruby binding to Termbox, a ncurses alternative.}
  s.homepage    = "http://github.com/jamescook/rb_termbox"
  s.license     = "MIT"

  s.add_dependency "ffi"
  s.add_development_dependency "rspec"

  s.files              = `git ls-files`.split("\n")
  s.test_files         = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths      = ["lib", "."]
  s.extensions         = %w[ext/termbox/extconf.rb]
end
