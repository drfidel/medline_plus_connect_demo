require 'medlineplus_ruby/api/api'

module MedlineplusRuby
  class Client
    include MedlineplusRuby::API

    def initialize(options = {})
      options.each do |key, value|
        instance_variable_set "@#{key}", value
      end
      yield(self) if block_given?
    end

  end
end
