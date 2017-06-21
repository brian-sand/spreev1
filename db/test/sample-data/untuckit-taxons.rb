include UntuckitShared

require 'yaml'

# extend Hash to have the ability to define hash key that is regex expression
class Hash
  def has_rkey?(search)
    keys.detect{ |reg_key| !!(reg_key =~ search) }
  end
end

@taxo_map = {
  "Womens" => {
    "Pants, Jumpsuits & Shorts" => {
      "Shorts"=> "Womens,Bottoms,Shorts",
      "Jumpsuits"=>  "Womens,Bottoms,Jumpsuits",
      "Pants"=>  "Womens,Bottoms,Pants",
      "default"=> "Womens,Bottoms,Pants"
    },
    "Bottoms" => {
      "Pants"=> "Womens,Bottoms,Pants",
      "Shorts"=> "Womens,Bottoms,Shorts",
      "Jeans" => "Womens,Bottoms,Jeans",
    },
    "Pants"=> "Womens,Bottoms,Pants",
    "Jeans" => "Womens,Bottoms,Jeans",
    "Skirts & Dresses" => [{
      /Gown/i => "Womens,Bottoms,Dresses & Rompers",
      /dress/i => "Womens,Bottoms,Dresses & Rompers",
      /skirt/i => "Womens,Bottoms,Skirts"
    }],
    "Dresses & Rompers" => "Womens,Bottoms,Dresses & Rompers",
    "Dresses" => "Womens,Bottoms,Dresses & Rompers",
    "Skirts" => "Womens,Bottoms,Skirts",
    "Sleepwear & Robes"=>"Womens,Sleepwear & Intimates",
    "Sleep & Intimates"=>"Womens,Sleepwear & Intimates",
    "All Accessories"=>"Womens,All Accessories",
    "Handbags"=>"Womens,Handbags",
    "Hats, Scarves & Gloves"=>"Womens,Hats, Scarves & Gloves",
    "Belts"=>"Womens,Belts",
    "Wallets & Small Leather Goods"=>"Womens,Wallets & Small Leather Goods",
    "Jewelry"=>"Womens,Jewelry",
    "Swimwear"=>"Womens,Swimwear",
    "Sunglasses & Eyeglasses"=>"Womens,Sunglasses & Eyeglasses",
    "Shirts & Tops"=>"Womens, Tops, Shirts",
    "Shirts"=>"Womens,Tops, Shirts",
    "Polo Shirts"=>"Womens, Tops, Polo Shirts",
    "Tops"=> {
      "Tees & Tanks"=>"Womens, Tops, Shirts",
      "Shirts & Blouses"=>"Womens, Tops, Shirts",
    },
    "Outerwear & Jackets"=>"Womens, Tops, Outerwear & Jackets",
    "Blazers & Vests"=>"Womens, Tops, Outerwear & Jackets",
    "Coats & Jackets"=>"Womens, Tops, Outerwear & Jackets",
    "Sweaters"=>"Womens, Tops, Sweaters",
    "Knits"=>"Womens,Knits",
    "All Shoes"=>"Womens,All Shoes"
  },
  "Mens" => {
    "Shirts" => "Mens, Shirts",
    "Polo" => "Mens, Polo"
  }
}

# raw_taxo_arr = "[Womans, "Pants, Jumpsuits & Shorts", Shorts]"
# return nil if no matching map
def get_first_match_taxo(raw_taxo_arr, temp_taxo_map, is_taxo_map_key_regex=false)
  cur_input_breadcrumb = raw_taxo_arr.shift.strip
  val = nil
  if(is_taxo_map_key_regex)
    key_match = temp_taxo_map.has_rkey?(cur_input_breadcrumb)
    val = temp_taxo_map[key_match] if !!key_match
  else
    val = temp_taxo_map[cur_input_breadcrumb]
  end
  if val.nil?
    val = temp_taxo_map["default"]
  elsif val.is_a?(Array)
    get_first_match_taxo(raw_taxo_arr, val[0], true)
  elsif val.is_a?(Hash)
    get_first_match_taxo(raw_taxo_arr, val, false)
  else
    val
  end
end



# @categories = "Categories_Definition"
@categories = Spree::Taxonomy.find_by_name!("Categories")
# brands = Spree::Taxonomy.find_by_name!(I18n.t('taxonomy_brands_name'))

@default_root_str = "categories"
@taxons = [{
  :name => "Categories",
  :taxonomy => @categories
}]

# taxon_str_arr = [Womens, Tops, Outerwear & Jackets]
def create_taxons(taxon_str_arr, product)
  new_taxon_str_arr=[]
  prev_taxon_str = nil
  cur_taxon = {}
  taxon_str_arr.each do |taxon_str|
    cur_taxon = {
      :name => taxon_str.strip,
      :taxonomy => @categories
    }
    # @taxons.append({
    #   :name => taxon_str.strip,
    #   :taxonomy => @categories
    # })
    if prev_taxon_str.nil?
      cur_taxon[:parent] = @default_root_str
    else
      cur_taxon[:parent] = prev_taxon_str
    end
    prev_taxon_str = cur_taxon[:parent] + "/" + taxon_str.strip.downcase
    @taxons.append(cur_taxon)
    # creating a stringify array of taxons so that striping out any spaces
    new_taxon_str_arr.append(taxon_str.strip)
#puts cur_taxon
  end

  if !cur_taxon.empty?
    cur_taxon[:taxon_arr_str]=new_taxon_str_arr
    cur_taxon[:product]=product
#puts "compare cur_taxon: #{cur_taxon}"
#puts "compare @taxons[-1]: #{@taxons[-1]}"
  end
end

csv_files_path.each do |p_file|
  puts "processing #{p_file}...."
  CSV.foreach(p_file) do |row|
    p_sku = row[1]
    product = Spree::Variant.where(sku: p_sku).first&.product
    #product="product1"
    p_taxo = YAML.load(row[6])
    p_taxo_mapped = get_first_match_taxo(p_taxo, @taxo_map, nil)
    if p_taxo_mapped.nil?
      puts "cannot find map for #{p_file}: #{row[6]}" 
     else
       create_taxons(p_taxo_mapped.split(","), product)
    end
  end
  puts "@taxons.count: #{@taxons.count}"
end

@taxons.each do |taxon_attrs|
#puts taxon_attrs
  t = nil
  if taxon_attrs[:parent].nil?
    t = Spree::Taxon.where(name: taxon_attrs[:name]).first_or_create! do  |taxon|
      taxon.taxonomy = taxon_attrs[:taxonomy]
    end
  else
    parent = Spree::Taxon.where(permalink: taxon_attrs[:parent]).first
    t_permalink = parent.permalink + "/" + taxon_attrs[:name].downcase
    t = Spree::Taxon.where(name: taxon_attrs[:name], permalink: t_permalink).first_or_create! do  |taxon|
      taxon.parent = parent
      taxon.taxonomy = taxon_attrs[:taxonomy]
    end
  end

  begin
    if(!taxon_attrs[:taxon_arr_str].nil? && !taxon_attrs[:product].nil?)
      t.products << taxon_attrs[:product]
      t.save!
    end
  rescue Exception => e
    puts e.message
    puts "context: #{taxon_attrs}"
  end  
end

# def find_match_product(taxons_arr, searched_taxon_attrs)
#   found_arr = []
#   if !searched_taxon_attrs[:products].nil?
#     product = searched_taxon_attrs[:products]
#     taxons_arr.each do |taxon_attrs|
#       if !taxon_attrs[:products].nil?
#         if (taxon_attrs[:products].id == product.id)
#           found_arr.append(taxon_attrs)
#         end
#       end
#     end
#   end
#   if found_arr.count >= 2
#     puts "found > 1 occurence of #{searched_taxon_attrs[:products].id} in"
#     found_arr.each do |taxon_attrs|
#       puts taxon_attrs
#     end
#     puts "==============================================================="
#   end
# end

# @taxons.each do |taxon_attrs|
#   find_match_product(@taxons, taxon_attrs)
# end


# puts "get_first_match_taxo(['Pants, Jumpsuits & Shorts', 'Shorts'], @taxo_map): #{get_first_match_taxo(['Pants, Jumpsuits & Shorts', 'Shorts'], @taxo_map)}"
# puts "get_first_match_taxo(['Pants, Jumpsuits & Shorts', 'Blah']): #{get_first_match_taxo(['Pants, Jumpsuits & Shorts', 'Blah'], @taxo_map)}"
# puts "get_first_match_taxo(['Pants']): #{get_first_match_taxo(['Pants'], @taxo_map)}"
# puts "get_first_match_taxo(['Pants,Blah']): #{get_first_match_taxo(['Pants,Blah'], @taxo_map)}"
# puts "get_first_match_taxo(['non existence']): #{get_first_match_taxo(['non existence'], @taxo_map)}"




