include UntuckitShared

default_shipping_category = Spree::ShippingCategory.find_by_name!("Default")
Spree::Config[:currency] = "HKD"

suppliers = {
  "Untuckit"  => Spree::Supplier.where(name: "Untuckit")&.first
}

csv_files_path.each do |p_file|
  CSV.foreach(p_file) do |row|
    p_name=row[0]
    p_sku=row[1]
    p_description=(row[2].nil? ? "" : row[2]) + "\n" + (row[3].nil? ? "" : row[3])
    p_price=row[4].gsub("$","")
    p_supplier=row[7]&.strip

    new_product = Spree::Product.where(name: p_name).first_or_create! do |product|
      product.sku=p_sku
      product.description = p_description
      product.price = p_price
      if Spree::Variant.column_names.include?('sale_price')
        product.sale_price = (product.price * rand(25..35) / 100).round(2)
      end
      product.available_on = Time.zone.now
      product.shipping_category = default_shipping_category
    end

    new_product.master&.supplier_variants.create!(supplier: suppliers[p_supplier])

  end
end
