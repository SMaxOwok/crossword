# frozen_string_literal: true

module Concerns
  module Filterable
    extend ActiveSupport::Concern

    class_methods do
      def filter(params)
        params ||= {}

        params.to_hash.inject all do |results, (key, value)|
          scopes = %I[by_#{key.to_s} with_#{key.to_s}]
          scopes.inject results do |query, scope|
            next query unless query.respond_to? scope

            query.send scope, value
          end
        end
      end
    end
  end
end
