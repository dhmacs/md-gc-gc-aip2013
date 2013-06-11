class CreateDistributors < ActiveRecord::Migration
  def change
    create_table :distributors do |t|
      t.string :name
      t.string :address
      t.string :cap
      t.string :city
      t.string :phone_number
      t.string :fax
      t.string :mail

      t.timestamps
    end
  end
end
