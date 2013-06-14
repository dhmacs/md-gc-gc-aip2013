class CreateGroupInfos < ActiveRecord::Migration
  def change
    create_table :group_infos do |t|
      t.string :title
      t.text :description
      t.boolean :is_entry_page

      t.references :group

      t.timestamps
    end
  end
end
