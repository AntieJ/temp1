class Investment < ApplicationRecord
  belongs_to :campaign

  validates :campaign, presence: true
  validates :amount, numericality: { greater_than: 0.0 }
  validate :amount_multiple

  after_commit :update_campaign_caches

  private

  def amount_multiple
    return if campaign.blank? || (amount % campaign.investment_multiple).zero?
    errors.add(:amount, "must be multiple of #{campaign.investment_multiple}")
  end

  def update_campaign_caches
    campaign.update_investments_caches
  end
end
