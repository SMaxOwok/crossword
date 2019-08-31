class PuzzleAuthorizer < ApplicationAuthorizer
  def creatable_by?(user)
    owns_resource?(user)
  end

  def updatable_by?(user)
    owns_resource? user
  end

  def deletable_by?(user)
    owns_resource? user
  end
end
