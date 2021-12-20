class AddVariantsCountField < ActiveRecord::Migration[6.1]
  def change
    add_column :bubbles, :variants_count, :integer
  end
end
