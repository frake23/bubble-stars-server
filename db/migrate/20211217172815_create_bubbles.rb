class CreateBubbles < ActiveRecord::Migration[6.1]
  def change
    create_table :bubbles do |t|
      t.string :title, null: false
      t.string :description, null: false
      t.integer :games_count, default: 0
      t.references :users, index: true, foreign_key: true
      t.integer :user_id

      t.timestamps
    end
    add_foreign_key :bubbles, :users
  end
end
