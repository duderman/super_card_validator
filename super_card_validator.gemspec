# Ensure we require the local version and not one we might have installed already
require File.join([
  File.dirname(__FILE__),
  'lib',
  'super_card_validator',
  'version.rb'
])

spec = Gem::Specification.new do |s|
  s.name = 'super_card_validator'
  s.version = SuperCardValidator::VERSION
  s.author = 'Nikolay Norkin'
  s.email = 'n.e.norkin@gmail.com'
  s.platform = Gem::Platform::RUBY
  s.summary = 'Super-puper card validator'
  s.files = `git ls-files`.split('
')
  s.require_paths << 'lib'
  s.has_rdoc = true
  s.extra_rdoc_files = ['README.rdoc', 'super_card_validator.rdoc']
  s.rdoc_options << '--title' << 'super_card_validator' << '--main' << 'README.rdoc' << '-ri'
  s.bindir = 'bin'
  s.executables << 'super_card_validator'
  s.add_development_dependency('rake')
  s.add_development_dependency('rdoc')
  s.add_development_dependency('aruba')
  s.add_runtime_dependency('gli', '2.13.3')
end
