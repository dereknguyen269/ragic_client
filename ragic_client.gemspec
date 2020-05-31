require_relative 'lib/ragic_client/version'

Gem::Specification.new do |spec|
  spec.name          = "ragic_client"
  spec.version       = RagicClient::VERSION
  spec.authors       = ["Derek Nguyen"]
  spec.email         = ["derek.nguyen.269@gmail.com"]

  spec.summary       = 'RagicClient'
  spec.description   = 'RagicClient is a simple tool integrate with RAGIC system.'
  spec.homepage      = "https://github.com/dereknguyen269/ragic_client"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["allowed_push_host"] = "Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/dereknguyen269/ragic_client"
  spec.metadata["changelog_uri"] = "https://github.com/dereknguyen269/ragic_client/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
