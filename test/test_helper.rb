$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "google/api/docs_v1/table_factory"

require "minitest/autorun"
require "minitest/reporters"

reporter_options = { color: true }
Minitest::Reporters.use! [Minitest::Reporters::DefaultReporter.new(reporter_options)]

require 'pry'