# frozen_string_literal: true

module Concerns
  module Sortable
    extend ActiveSupport::Concern

    included do
      SORTABLE_DIRECTIONS = %w[ASC DESC asc desc].freeze

      scope :with_order, ->(order) { order(order) if order.present? }
    end

    class_methods do
      def sorted(params)
        column = @allowed_attributes.include?(params[:sorting]) ? params[:sorting] : @default_sort
        direction = SORTABLE_DIRECTIONS.include?(params[:direction]) ? params[:direction] : :desc

        with_order column => direction
      end

      def sortable_attributes(*attributes, default: :created_at)
        @allowed_attributes = attributes.map(&:to_s)
        @default_sort = default
      end
    end
  end
end
