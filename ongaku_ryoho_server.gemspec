# -*- encoding: utf-8 -*-
require File.expand_path('../lib/ongaku_ryoho_server/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Steven Vandevelde"]
  gem.email         = ["icid.asset@gmail.com"]
  gem.description   = %q{Serves music to Ongaku Ryoho clients}
  gem.summary       = %q{Serves music to Ongaku Ryoho clients}
  gem.homepage      = "https://github.com/icidasset/ongaku_ryoho_server"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "ongaku_ryoho_server"
  gem.require_paths = ["lib"]
  gem.version       = OngakuRyohoServer::VERSION

  gem.add_dependency 'json', '~> 1.6.6'
  gem.add_dependency 'ruby-mp3info', '~> 0.7.1'
  gem.add_dependency 'sinatra', '~> 1.3.2'
  gem.add_dependency 'puma'
  gem.add_dependency 'daemons'

  gem.add_development_dependency 'rake'
end
