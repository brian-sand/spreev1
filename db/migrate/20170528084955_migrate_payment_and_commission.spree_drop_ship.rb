# This migration comes from spree_drop_ship (originally 20140416184616)
class MigratePaymentAndCommission < ActiveRecord::Migration
  def change
    add_column :spree_payments, :payable_id, :integer
    add_column :spree_payments, :payable_type, :string
    add_index :spree_payments, [:payable_id, :payable_type]
  end
end
