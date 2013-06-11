class CreateGroupInfos < ActiveRecord::Migration
  def change
    create_table :group_infos do |t|
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
