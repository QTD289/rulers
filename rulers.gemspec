require_relative 'lib/rulers/version'

Gem::Specification.new do |spec|
  spec.name          = 'rulers'
  spec.version       = Rulers::VERSION
  spec.authors       = ['QTD']
  spec.email         = ['tranduc811@gmail.com']

  spec.summary       = 'RoR from scratch'
  spec.description   = 'Rebuild Ruby on Rails framework from scrach'
  spec.homepage      = 'https://github.com/QTD289/rulers'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.4')

  spec.metadata['allowed_push_host'] = 'github.com'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/QTD289/rulers'
  spec.metadata['changelog_uri'] = 'https://github.com/QTD289/rulers'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'erubi'
  spec.add_runtime_dependency 'multi_json'
  spec.add_runtime_dependency 'pry'
  spec.add_runtime_dependency 'rack'

  spec.add_development_dependency 'rack-test'
end
