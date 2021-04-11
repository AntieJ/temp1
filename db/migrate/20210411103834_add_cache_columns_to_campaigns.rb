class AddCacheColumnsToCampaigns < ActiveRecord::Migration[6.1]
  def change
    add_column :campaigns, :percentage_raised, :decimal, default: 0.0
    add_column :campaigns, :investments_count, :integer, default: 0
  end
end
