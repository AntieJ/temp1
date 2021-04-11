require 'rails_helper'

RSpec.describe Investment, type: :model do
  let(:campaign) { create(:campaign) }
  let(:subject) { create(:investment, campaign: campaign, amount: campaign.investment_multiple) }

  describe 'columns' do
    it { expect(subject).to have_db_column(:amount) }
  end

  describe 'associations' do
    it { expect(subject).to belong_to(:campaign) }
  end

  describe 'validations' do
    it { expect(subject).to validate_presence_of(:campaign) }
    it { expect(subject).to validate_numericality_of(:amount) }

    describe 'amount_multiple' do
      let(:campaign) { create(:campaign, investment_multiple: 1.5) }

      it 'should fail validation if amount is not multiple of campaign investment_multiple' do
        investment = build(:investment, campaign: campaign, amount: 2)
        expect(investment.valid?).to be false
        expect(investment.errors[:amount]).to include 'must be multiple of 1.5'
      end
    end
  end

  describe 'callbacks' do
    describe 'update_campaign_caches' do
      let(:campaign) { create(:campaign, target_amount: 100_000, investment_multiple: 1) }
      let!(:investment_a) { create(:investment, campaign: campaign, amount: 20_000) }

      it 'should update campaign caches on create' do
        expect { create(:investment, campaign: campaign, amount: 30_000) }.to change {
          campaign.attributes.values_at('investments_count', 'percentage_raised')
        }.from([1, 0.2]).to([2, 0.5])
      end

      it 'should update campaign caches on update' do
        expect { investment_a.update(amount: 60_000) }.to change {
          campaign.attributes.values_at('investments_count', 'percentage_raised')
        }.from([1, 0.2]).to([1, 0.6])
      end

      it 'should update campaign caches on destroy' do
        expect { investment_a.destroy }.to change {
          campaign.attributes.values_at('investments_count', 'percentage_raised')
        }.from([1, 0.2]).to([0, 0])
      end
    end
  end
end
