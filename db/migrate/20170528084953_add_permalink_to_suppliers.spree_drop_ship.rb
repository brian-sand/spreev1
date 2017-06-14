# This migration comes from spree_drop_ship (originally 20130606220913)
class AddPermalinkToSuppliers < ActiveRecord::Migration
  def change
    add_column :spree_suppliers, :slug, :string
    add_index :spree_suppliers, :slug, unique: true
  end
end
