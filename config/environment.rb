# Load the Rails application.
require_relative "application"

# Initialize the Rails application.
Rails.application.initialize!

if Rails.env.development? && ARGV.include?("erd")
  Zeitwerk::Loader.eager_load_all
end
