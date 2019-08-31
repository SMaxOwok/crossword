class StatisticsAuthorizer < ApplicationAuthorizer
  def readable_by?(user)
    owns_resource? user
  end
end
