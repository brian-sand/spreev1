require_relative 'shared'

include Shared

# csv_files_path.each do |f|
#   puts "#{f}"
# end 


load_sample_file("payment_methods")
load_sample_file("shipping_categories")
load_sample_file("shipping_methods")
load_sample_file("tax_categories")
load_sample_file("tax_rates")
load_sample_file("suppliers")

load_sample_file("products")
load_sample_file("taxonomies")
load_sample_file("taxons")
load_sample_file("stock")

load_sample_file("assets")

