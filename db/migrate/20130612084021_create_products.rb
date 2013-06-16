class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.boolean :top_design, :default => false
      t.text :technical_details

      t.references :room
      t.references :category
      t.references :designer
      t.references :manufacturer, :polymorphic => true

      t.timestamps
    end
  end
end
