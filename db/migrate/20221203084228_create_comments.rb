class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.integer :flyer_id, null: false
      t.integer :user_id, null: false
      t.string :comment, null: false
      t.boolean :is_deleted, null: false, default: false
      t.timestamps
    end
  end
end
