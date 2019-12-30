lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "google/api/docs_v1/table_factory/version"

Gem::Specification.new do |spec|
  spec.name          = "google-docs-table-factory"
  spec.version       = Google::Api::DocsV1::TableFactory::VERSION
  spec.authors       = ["Gustavo Matias"]
  spec.email         = ["gustavo@matias.love"]

  spec.summary       = "Ruby library for managing tables on Google Documents using the Google API"
  spec.description   = %q{
    The purpose of this library is to provide simpler ways for manipulating table and its contents in Google Docs.

    This solve for the difficulty myself and a few others had when attempting to manage tables on Google Docs using the Google Docs V1 API.
  }
  spec.homepage      = "https://github.com/gumatias/google-docs-table-factory"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/gumatias/google-docs-table-factory"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
end
