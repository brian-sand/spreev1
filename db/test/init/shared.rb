module Shared

  require 'csv'
  def csv_files_path
    root_data_path = File.join(File.dirname(__FILE__), '..', 'data')

    products_file = [
      File.join(root_data_path, 'ralph-sale', 'ralph-w-sale.csv'),
      File.join(root_data_path, 'ralph-sale', 'ralph-w-sale-2.csv'),
      File.join(root_data_path, 'ralph-sale', 'ralph-w-sale-3.csv'),
      File.join(root_data_path, 'ralph-sale', 'ralph-w-sale-4.csv'),
      File.join(root_data_path, 'ralph-sale', 'ralph-w-sale-5.csv'),
      File.join(root_data_path, 'ralph-sale', 'ralph-w-sale-6.csv'),
      File.join(root_data_path, 'ab-sales', 'abercrombie-sale-1.csv'),
      File.join(root_data_path, 'ab-sales', 'abercrombie-sale-outwear.csv'),
      File.join(root_data_path, 'ab-sales', 'abercrombie-sale-tees.csv'),
      File.join(root_data_path, 'ab-sales', 'abercrombie-sale-shorts.csv'),
      File.join(root_data_path, 'ab-sales', 'abercrombie-sale-sleep.csv'),
      File.join(root_data_path, 'untuckit', 'untuckit-sale-1.csv')
    ]
  end

  def load_sample_file(file)
    # Otherwise we will use this gems default file.
    path = File.expand_path(samples_path + "#{file}.rb")
    # Check to see if the specified file has been loaded before
    if !$LOADED_FEATURES.include?(path)
      require path
      puts "Loaded #{file.titleize} samples"
    end
  end

  private
    def samples_path
      Pathname.new(File.join(File.dirname(__FILE__), '..', 'sample-data'))
    end

end
