class CreateUserapis < ActiveRecord::Migration[6.0]
  def change
    create_table :userapis do |t|
      t.string :apikey
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
