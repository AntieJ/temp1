require 'rails_helper'

RSpec.describe Campaign, type: :model do
  describe 'columns' do
    it { expect(subject).to have_db_column(:name) }
    it { expect(subject).to have_db_column(:image_url) }
    it { expect(subject).to have_db_column(:sector) }
    it { expect(subject).to have_db_column(:country) }
    it { expect(subject).to have_db_column(:target_amount) }
    it { expect(subject).to have_db_column(:investment_multiple) }
    it { expect(subject).to have_db_column(:percentage_raised) }
    it { expect(subject).to have_db_column(:investments_count) }
  end

  describe 'associations' do
    it { expect(subject).to have_many(:investments).dependent(:destroy) }
  end

  describe 'validations' do
    it { expect(subject).to validate_numericality_of(:target_amount) }
  end
end
