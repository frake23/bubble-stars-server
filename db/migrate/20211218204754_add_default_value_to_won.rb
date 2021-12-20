class AddDefaultValueToWon < ActiveRecord::Migration[6.1]
  def change
    change_column :bubble_variants, :won_times, :integer, default: 0
  end
end
