# This migration comes from spree_drop_ship (originally 20130405005502)
class StockLocationsBelongsToSupplier < ActiveRecord::Migration
  def change
    add_column :spree_stock_locations, :supplier_id, :integer
    add_index :spree_stock_locations, :supplier_id
  end
end
