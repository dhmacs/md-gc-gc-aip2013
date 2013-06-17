class CreatePartners < ActiveRecord::Migration
  def change
    create_table :partners do |t|
      t.string :name
      t.text :description
      t.string :website
      t.references :group

      t.timestamps
    end
  end
end
