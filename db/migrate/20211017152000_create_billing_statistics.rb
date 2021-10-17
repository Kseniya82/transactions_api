class CreateBillingStatistics < ActiveRecord::Migration[6.1]
  def change
    create_table :billing_statistics do |t|
      t.date :date_from
      t.date :date_to
      t.references :user, type: :uuid, foreign_key: true
      t.jsonb :content

      t.timestamps
    end
  end
end
