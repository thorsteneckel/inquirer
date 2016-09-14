# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'inquirer/version'

Gem::Specification.new do |spec|
  spec.name    = 'inquirer.rb'
  spec.version = Inquirer::VERSION
  spec.authors = ['Thorsten Eckel']

  spec.summary     = 'A collection of common interactive command line user interfaces.'
  spec.description = 'A collection of common interactive command line user interfaces. A (not yet compleded) clone of the great Inquirer.js (https://github.com/SBoudrias/Inquirer.js) and strongly inspired by the similar inquirer.rb (https://github.com/arlimus/inquirer.rb).'
  spec.homepage    = 'https://github.com/thorsteneckel/inquirer'
  spec.license     = 'MIT'

  spec.files         = Dir['{lib}/**/*']
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.12'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.5'

  if( RUBY_VERSION.start_with? '1.' )
    spec.add_dependency 'term-ansicolor', '~> 1.2.2'
  else
    spec.add_dependency 'term-ansicolor', '>= 1.3'
  end

  if( RUBY_ENGINE == 'rbx' )
    spec.add_dependency 'rubysl-mutex_m'
    spec.add_dependency 'rubysl-singleton'
    spec.add_dependency 'rubysl-io-console'
  end
end
