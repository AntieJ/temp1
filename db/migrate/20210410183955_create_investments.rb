class CreateInvestments < ActiveRecord::Migration[6.1]
  def change
    create_table :investments do |t|
      t.references :campaign, null: false, foreign_key: true
      t.decimal :amount

      t.timestamps
    end
  end
end
