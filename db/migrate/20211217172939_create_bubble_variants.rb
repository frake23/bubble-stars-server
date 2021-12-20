class CreateBubbleVariants < ActiveRecord::Migration[6.1]
  def change
    create_table :bubble_variants do |t|
      t.references :bubbles, index: true, foreign_key: true
      t.integer :bubble_id
      t.string :name
      t.integer :won_times

      t.timestamps
    end
    add_foreign_key :bubble_variants, :bubbles
  end
end
