require 'carmen'

# connection      = ActiveRecord::Base.connection
# country_inserts = []

# country_values = -> do
#   Carmen::Country.all.each do |country|
#     name            = connection.quote country.name
#     iso3            = connection.quote country.alpha_3_code
#     iso             = connection.quote country.alpha_2_code
#     iso_name        = connection.quote country.name.upcase
#     numcode         = connection.quote country.numeric_code
#     states_required = connection.quote country.subregions?

#     country_inserts << [name, iso3, iso, iso_name, numcode, states_required].join(", ")
#   end

#   country_inserts.join("), (")
# end

# columns = ["name", "iso3", "iso", "iso_name", "numcode", "states_required"]
# columns = connection.adapter_name =~ /MySQL/i ? columns.join(", ") : "\"#{columns.join('", "')}\""

# connection.execute <<-SQL
#   INSERT INTO spree_countries (#{columns})
#   VALUES (#{country_values.call});
# SQL

# Spree::Config[:default_country_id] = Spree::Country.find_by(iso: "US").id

Carmen::Country.all.map do |country|
  name = country.name
  iso3 = country.alpha_3_code
  iso = country.alpha_2_code
  iso_name = country.name.upcase
  numcode = country.numeric_code
  states_required = country.subregions?

  # country_inserts << [name, iso3, iso, iso_name, numcode, states_required].join(", ")
  Spree::Country.new(:name => name,
      :iso3 => iso3,
      :iso => iso,
      :iso_name => iso_name,
      :numcode => numcode,
      :states_required => states_required
  ).save!
end

hk = Spree::Country.find_by(iso: "HK")
Spree::Config[:default_country_id] = hk.id

