class CreateDesires < ActiveRecord::Migration
  def change
    create_table :desires do |t|
      t.text :content
      t.integer :user_id

      t.timestamps
    end
    add_index :desires, [:user_id, :created_at]
  end
end
