class AddCategoryToUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.references :category
    end
  end
end
