class CreateTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :transactions, id: :uuid do |t|
      t.string :name
      t.money :amount
      t.references :user, type: :uuid, foreign_key: true
      t.datetime :billing_at, null: false
      t.string :state

      t.timestamps
    end
  end
end
