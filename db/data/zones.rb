eu_vat = Spree::Zone.create!(name: "EU_VAT", description: "Countries that make up the EU VAT zone.", kind: 'country')
north_america = Spree::Zone.create!(name: "North America", description: "USA + Canada", kind: 'country')
east_asia = Spree::Zone.create!(name: "East Asia", description: "Countries in East Asia")
sea = Spree::Zone.create!(name: "South East Asia", description: "Countries in South East Asia")

%w(PL FI PT RO DE FR SK HU SI IE AT ES IT BE SE LV BG GB LT CY LU MT DK NL EE HR CZ GR).
each do |name|
  eu_vat.zone_members.create!(zoneable: Spree::Country.find_by!(iso: name))
end

%w(US CA).each do |name|
  north_america.zone_members.create!(zoneable: Spree::Country.find_by!(iso: name))
end

%w(CN TW KR JP HK MO MN).
each do |name|
  east_asia.zone_members.create!(zoneable: Spree::Country.find_by!(iso: name))
end

%w(BN KH ID LA MY MM PH SG TH TL VN).
each do |name|
  sea.zone_members.create!(zoneable: Spree::Country.find_by!(iso: name))
end