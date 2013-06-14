class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.string :name
      t.text :description
      t.text :additional_info

      t.timestamps
    end
  end
end
