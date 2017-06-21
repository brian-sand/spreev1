include UntuckitShared

ut_dir_path = File.join(File.dirname(__FILE__), '..', 'data','untuckit')
@dir_path_map = {
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

csv_files_path.each do |p_file|
  CSV.foreach(p_file) do |row|
    p_sku=p_sku=row[1]
    puts "Loading images for #{p_sku}"
    variant = Spree::Variant.where(sku: p_sku).first
    images_for(variant.suppliers.first.name, p_sku)&.each do |img_path|
      img_file = File.open(img_path)
      variant.images.create!(attachment: img_file)
    end
  end
end

