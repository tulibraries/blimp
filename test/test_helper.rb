# Configure Rails Environment
ENV["RAILS_ENV"] = "test"

require File.expand_path("../../test/dummy/config/environment.rb", __FILE__)
require "rails/test_help"

migration_paths = [
  File.expand_path("dummy/db/migrate", __dir__),
  File.expand_path("../db/migrate", __dir__)
]

if defined?(ActiveRecord::Tasks::DatabaseTasks)
  ActiveRecord::Tasks::DatabaseTasks.migrations_paths = migration_paths
end

ActiveRecord::Migration.maintain_test_schema!

# Filter out Minitest backtrace while allowing backtrace from other libraries
# to be shown.
Minitest.backtrace_filter = Minitest::BacktraceFilter.new


# Load fixtures from the engine
fixture_path = File.expand_path("fixtures", __dir__)

if ActiveSupport::TestCase.respond_to?(:fixture_paths=)
  ActiveSupport::TestCase.fixture_paths = [fixture_path]
  ActionDispatch::IntegrationTest.fixture_paths = ActiveSupport::TestCase.fixture_paths
  ActiveSupport::TestCase.file_fixture_path = File.join(fixture_path, "files")
  ActiveSupport::TestCase.fixtures :all
elsif ActiveSupport::TestCase.respond_to?(:fixture_path=)
  ActiveSupport::TestCase.fixture_path = fixture_path
  ActionDispatch::IntegrationTest.fixture_path = fixture_path
  ActiveSupport::TestCase.file_fixture_path = File.join(fixture_path, "files")
  ActiveSupport::TestCase.fixtures :all
end
