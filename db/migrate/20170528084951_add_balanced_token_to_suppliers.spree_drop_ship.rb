# This migration comes from spree_drop_ship (originally 20130428063053)
class AddBalancedTokenToSuppliers < ActiveRecord::Migration
  def change
    add_column :spree_suppliers, :tax_id, :string
    add_column :spree_suppliers, :token, :string
    add_index :spree_suppliers, :token
  end
end
