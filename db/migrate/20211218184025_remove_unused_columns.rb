class RemoveUnusedColumns < ActiveRecord::Migration[6.1]
  def change
    remove_column :bubbles, :users_id
    remove_column :bubble_variants, :bubbles_id
  end
end
