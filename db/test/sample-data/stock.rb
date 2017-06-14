
country =  Spree::Country.find_by(iso: 'US')

supplier_stock_loc_map = {}

Spree::Supplier.all.each do |supplier|
  location = Spree::StockLocation.first_or_create! name: "#{supplier.name}-loc1", address1: 'Example Street', city: 'City', zipcode: '12345', country: country, state: country.states.first
  location.active = true
  location.propagate_all_variants = false
  location.supplier = supplier
  location.save!
  supplier_stock_loc_map[supplier.name] = location
end

#self.stock_items.create!(variant: variant, backorderable: self.backorderable_default)
Spree::Variant.all.each do |variant|
  stock_loc = supplier_stock_loc_map[variant.suppliers&.first.name]
  stock_item = stock_loc.stock_items.create!(variant: variant, backorderable: stock_loc.backorderable_default)
  Spree::StockMovement.create(:quantity => 10, :stock_item => stock_item)
end
