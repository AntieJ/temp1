class Campaign < ApplicationRecord
  has_many :investments, dependent: :destroy

  validates :target_amount, :investment_multiple, numericality: { greater_than: 0.0 }

  scope :by_sector, ->(sectors) { where(sector: sectors) }

  scope :by_investments_count, ->(from, to) {
    query = where(nil)
    query = query.where('investments_count >= ?', from) if from.present?
    query = query.where('investments_count <= ?', to) if to.present?
    query
  }

  def update_investments_caches
    investments_table = Investment.arel_table
    count, sum = *investments.pluck(investments_table[:id].count, investments_table[:amount].sum).first
    self.update(
      investments_count: count,
      percentage_raised: (sum.to_f / target_amount)
    )
  end
end
