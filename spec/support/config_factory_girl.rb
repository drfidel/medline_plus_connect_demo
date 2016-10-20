RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
end

# Allow FactoryGirl to use the new RSpec 3.5+ syntax for stubbing methods. This
#  simplifies stubbing values for privately accessible attributes.
# @see https://github.com/thoughtbot/factory_girl/issues/703
FactoryGirl::SyntaxRunner.class_eval do
  include RSpec::Mocks::ExampleMethods
end
