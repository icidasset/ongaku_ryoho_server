# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "ongaku_ryoho_server"
  s.version = "0.4.0"

  s.authors = ["Steven Vandevelde"]
  s.email = ["icid.asset@gmail.com"]
  s.description = "Serves music to Ongaku Ryoho clients"
  s.summary = "Serves music to Ongaku Ryoho clients"
  s.homepage = "https://github.com/icidasset/ongaku_ryoho_server"

  s.files = `git ls-files`.split($\)
  s.executables = s.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  s.test_files = s.files.grep(%r{^(test|spec|features)/})

  s.require_paths = ["lib"]
  s.required_ruby_version = Gem::Requirement.new(">= 1.8.7")

  s.add_dependency "oj", "~> 2.0.14"
  s.add_dependency "taglib-ruby", "~> 0.6.0"
  s.add_dependency "sinatra", "~> 1.4.2"
  s.add_dependency "puma", "~> 2.0.1"

  s.add_development_dependency "rake"
end
