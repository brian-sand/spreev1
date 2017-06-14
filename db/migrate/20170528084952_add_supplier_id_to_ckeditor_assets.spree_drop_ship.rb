# This migration comes from spree_drop_ship (originally 20130510181443)
class AddSupplierIdToCkeditorAssets < ActiveRecord::Migration
  if table_exists?(:ckeditor_assets)
    def change
      add_column :ckeditor_assets, :supplier_id, :integer
      add_index  :ckeditor_assets, :supplier_id
    end
  end
end
