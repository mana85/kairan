class CreateFlyers < ActiveRecord::Migration[6.1]
  def change
    create_table :flyers do |t|
      t.integer :user_id, null: false
      t.string :title, null: false
      t.text :body, null: false
      t.text :url, null: false
      t.date :alert_date
      t.boolean :is_deleted, null: false, default: false
      t.timestamps
    end
  end
end
