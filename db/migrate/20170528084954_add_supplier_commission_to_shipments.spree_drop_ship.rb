# This migration comes from spree_drop_ship (originally 20140323170638)
class AddSupplierCommissionToShipments < ActiveRecord::Migration
  def change
    add_column :spree_shipments, :supplier_commission, :decimal, precision: 8, scale: 2, default: 0.0, null: false
  end
end
