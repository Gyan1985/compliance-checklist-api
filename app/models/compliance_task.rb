class ComplianceTask < ApplicationRecord
  before_save :update_status_based_on_due_date

  validates :title, :due_date, :status, presence: true

  private

  def update_status_based_on_due_date
    if status == 'pending' && due_date.present? && due_date < Time.current
      self.status = 'overdue'
    end
  end
end
