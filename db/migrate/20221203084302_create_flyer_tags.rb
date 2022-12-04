class CreateFlyerTags < ActiveRecord::Migration[6.1]
  def change
    create_table :flyer_tags do |t|

      t.integer :flyer_id, null: false
      t.integer :tag_id, null: false
      t.timestamps
    end
  end
end
