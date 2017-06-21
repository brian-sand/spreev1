
ab_dir_path = File.join(File.dirname(__FILE__), '..', 'data','ab-sales')
rl_dir_path = File.join(File.dirname(__FILE__), '..', 'data','ralph-sale')
ut_dir_path = File.join(File.dirname(__FILE__), '..', 'data','untuckit')
@dir_path_map = {
  "Ralph Lauren" => rl_dir_path,
  "Abercrombie" => ab_dir_path,
  "Untuckit" => ut_dir_path
}

# return an array of file_path(s)
def images_for(brand, sku, type="jpg")
  sku_images_path = File.expand_path(Pathname.new(@dir_path_map[brand]) + sku)
  if File.exist?(sku_images_path)
    Dir.glob(File.join(sku_images_path, "*.#{type}")).each do |f_path|
      #File.open(f_path)
      f_path
    end
  else
    puts "[#{brand}] images SKU #{sku_images_path} directory not exist"
  end
end

Spree::Variant.all.each do |v|
  puts "Loading images for #{v.product.name}"
  images_for(v.suppliers.first.name, v.sku)&.each do |img_path|
    f_name = File.basename(img_path)
    if v.images.where(attachment_file_name: f_name).none?
      img_file = File.open(img_path)
      v.images.create!(attachment: img_file)
    end
  end
end

