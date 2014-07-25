# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'canvas/resize/rails/version'

Gem::Specification.new do |spec|
  spec.name          = "canvas-resize-rails"
  spec.version       = Canvas::Resize::Rails::VERSION
  spec.authors       = ["maedana"]
  spec.email         = ["maeda.na@gmail.com"]
  spec.summary       = %q{Use canvasResize with Rails and carrierwave}
  spec.description   = %q{This gem provides canvasResize driver for your Rails Application}
  spec.homepage      = "https://github.com/maedana/canvas-resize-rails"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_dependency 'activesupport', '~>3.2'
  spec.add_dependency 'activerecord', '~>3.2'
end
