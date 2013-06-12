class CreateDesigners < ActiveRecord::Migration
  def change
    create_table :designers do |t|
      t.string :first_name
      t.string :last_name
      t.text :biography

      t.timestamps
    end
  end
end
