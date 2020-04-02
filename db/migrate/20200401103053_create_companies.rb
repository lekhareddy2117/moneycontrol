class CreateCompanies < ActiveRecord::Migration[6.0]
  def change
    create_table :companies do |t|
      t.string :c_code
      t.string :c_name

      t.timestamps
    end
    add_index :companies, :c_code,  unique: true
  end
end
