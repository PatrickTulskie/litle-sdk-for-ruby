lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |gem|
  gem.name                  = "LitleOnline"
  gem.summary               = "Ruby SDK produced by Litle & Co. for online transaction processing using Litle XML format v8.15"
  gem.description           = File.read(File.join(File.dirname(__FILE__), 'DESCRIPTION'))
  gem.requirements          = ['Contact sdksupport@litle.com for more information']
  gem.version               = "8.15.0"
  gem.author                = "Litle & Co"
  gem.email                 = "sdksupport@litle.com"
  gem.homepage              = "http://www.litle.com/developers"
  gem.required_ruby_version = '>=1.8.6'
  gem.has_rdoc              = true
  
  gem.files                 = `git ls-files`.split($/)
  gem.executables           = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.require_paths         = ["lib"]
  gem.test_files            = Dir["test/unit/ts_unit.rb"]
  gem.platform              = Gem::Platform::RUBY
  
  gem.add_dependency('xml-object')
  gem.add_dependency('xml-mapping')
  gem.add_development_dependency('mocha')
end