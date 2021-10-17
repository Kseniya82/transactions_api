class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    enable_extension 'pgcrypto'
    create_table :users, id: :uuid do |t|
      t.money :balance

      t.timestamps
    end
  end
end
