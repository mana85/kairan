class CreateClips < ActiveRecord::Migration[6.1]
  def change
    create_table :clips do |t|

      t.integer :user_id, null: false
      t.integer :flyer_id, null: false
      t.boolean :is_alert, null: false, default: false
      t.timestamps
    end
  end
end
