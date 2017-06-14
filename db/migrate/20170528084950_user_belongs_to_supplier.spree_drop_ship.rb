# This migration comes from spree_drop_ship (originally 20130405011127)
class UserBelongsToSupplier < ActiveRecord::Migration
  def change
    add_column Spree.user_class.table_name, :supplier_id, :integer
    add_index Spree.user_class.table_name, :supplier_id
  end
end
