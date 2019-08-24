# frozen_string_literal: true

module ApplicationHelper
  def sortable_header(params, column, title = nil)
    title ||= column.to_s.titleize

    next_direction, classname = case params[:direction]
                                when 'ASC' then %w[DESC sort-ascending]
                                when 'DESC' then %w[ASC sort-descending]
                                else %w[ASC sort-descending]
                                end
    classname = 'sort-none' unless params[:sorting] == column

    link_params = params.to_unsafe_h.merge sorting: column,
                                           direction: next_direction

    link_to title, link_params, class: "sortable-header #{classname}"
  end
end
