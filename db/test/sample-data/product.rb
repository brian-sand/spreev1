include Shared

# default_shipping_category = Spree::ShippingCategory.find_by_name!("Default")
# Spree::Config[:currency] = "HKD"

# csv_files_path.each do |p_file|
#   CSV.foreach(p_file) do |row|
#     p_name=row[0]
#     p_sku=row[1]
#     p_description=row[2] + "\n" + row[3]
#     p_price=row[4].gsub("$","")

#     new_product = Spree::Product.where(name: p_name).first_or_create! do |product|
#       new_product.sku=p_sku
#       new_product.description = p_description
#       new_product.price = price
#       new_product.save
#     end
#   end
# end




# a             {}
# a->b          a=>{b=>{}}
# a->b->c       a=>{b=>{c=>{}}} 
# a->b->c->d    a=>{b=>{c=>{d=>{}}}} 
# a->b->c2       a=>{b=>{ c=>{},c2=>{} }} 
# a->b->c3       a=>{b=>{ c=>{},c2=>{},c3=>{} }} 
# a->b->c2->d2       a=>{b=>{ c=>{},c2=>{ d2=>{} },c3=>{} } 

# @taxonomies={}

# def retrieve_or_create(taxo_arr)
#   cur_taxonomies = nil
#   taxo_arr.each do |taxo|
#     if !cur_taxonomies.nil? && cur_taxonomies.has_key?(taxo) 
#       cur_taxonomies = cur_taxonomies[taxo]
#     elsif @taxonomies.has_key?(taxo)
#       cur_taxonomies = @taxonomies[taxo]
#     elsif cur_taxonomies.nil? || cur_taxonomies == 0
#       @taxonomies[taxo] = {}
#       cur_taxonomies = @taxonomies[taxo]
#     else
#       cur_taxonomies[taxo] = {}
#       cur_taxonomies = cur_taxonomies[taxo]
#     end
#   end
# end

# require 'yaml'
# csv_files_path.each do |p_file|
#   CSV.foreach(p_file) do |row|
#     retrieve_or_create(YAML.load(row[6]))
#   end
# end

# def recurse_hash(myhash, depth)
#   depth += 1
#   if myhash.is_a?(Hash) && myhash.size <= 0
#     return ""
#   else
#     myhash.keys.each do |key|
#       puts "#{' ' * depth}  #{key}"
#       recurse_hash(myhash[key], depth)
#     end
#   end
# end

# recurse_hash(@taxonomies, 0)