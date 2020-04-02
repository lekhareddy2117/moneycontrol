class CreateStocks < ActiveRecord::Migration[6.0]
  def change
    create_table :stocks do |t|
      t.date :date
      t.float :open
      t.float :close
      t.float :high
      t.float :low
      t.float :volume
      t.float :value
      t.references :company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
