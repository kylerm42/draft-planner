source 'https://rubygems.org'

# Essential
gem 'rails',                '4.2.1'                 # Core Rails gem
gem 'rails-api'
gem 'pg'                                            # Postgres database
gem 'thin'                                          # Lightweight webserver
gem 'database_cleaner'                              # Ensure clean slate during tests

# Views/JSON/Filtering
gem 'json'                                          # JSON support
gem 'active_model_serializers'                      # Convention JSON output

# Authorization
gem 'devise_token_auth'                             # User authentication for Angular
gem 'omniauth'                                      # Authentication through Google, Facebook, etc.
gem 'pundit'                                        # Policies

group :development do
  gem 'web-console',        '~> 2.0'                # IRB console with <%= console %> in views
  gem 'spring'                                      # Fast app loading
  gem 'annotate'                                    # Model attributes helper
  gem 'letter_opener'                               # Email simulation
  gem 'rubocop'                                     # Code style analyzer
end

group :development, :test do
  gem 'pry-rails'                                   # Better than IRB
  gem 'byebug'                                      # Helpful debugger
  gem 'hirb'                                        # Table IRB output
  gem 'rspec-rails'                                 # Rspec core gem
  gem 'json_spec'                                   # JSON test helpers
  gem 'factory_girl_rails'                          # Test data factories
  gem 'faker'                                       # Test data attributes
end

group :test do
  # gem 'shoulda-matchers'                            # Extra test helpers
  gem 'capybara'                                    # Web interaction testing
end
