namespace :prices do
  desc "Import material prices from JSON file"
  task import: :environment do
    begin
      # Check if directory exists
      data_dir = Rails.root.join('data', 'prices')
      archive_dir = data_dir.join('archive')

      unless Dir.exist?(data_dir)
        puts "Error: Directory not found: #{data_dir}"
        puts "Please create the directory and add your JSON files."
        exit
      end

      unless Dir.exist?(archive_dir)
        puts "Creating archive directory..."
        FileUtils.mkdir_p(archive_dir)
      end
      
      # Find the most recent JSON file
      json_files = Dir[data_dir.join('*.json')]
      if json_files.empty?
        puts "Error: No JSON files found in #{data_dir}"
        puts "Please place your JSON file in the directory."
        exit
      end

      latest_file = json_files.max_by { |f| File.mtime(f) }
      puts "Processing #{latest_file}..."

      # Material type selection
      puts "\nSelect Material Type:"
      puts "[M] Materials"
      puts "[L] Liquids"
      puts "[P] Precious Metals"
      puts "[C] Currency"
      print "\nChoice: "
      
      choice = STDIN.gets.chomp.upcase
      config_type = case choice
        when 'M' then 'materials'
        when 'L' then 'liquids'
        when 'P' then 'precious_metals'
        when 'C' then 'currency'
        else
          puts "Invalid choice!"
          exit
      end

      # Validate JSON structure
      begin
        json_data = File.read(latest_file)
        parsed_data = JSON.parse(json_data)
        
        # Check required JSON structure based on file type
        if choice == 'C'
          unless parsed_data["conversion_rates"]
            puts "Error: Invalid JSON structure for currency"
            puts "Expected format:"
            puts '{
  "conversion_rates": {
    "EUR": 0.97,
    "GBP": 0.81,
    ...
  }
}'
            exit
          end
        else
          # Original metals validation
          unless parsed_data["data"] && 
                 parsed_data["data"]["rates"] && 
                 parsed_data["data"]["rates"].any? { |k, _| k.start_with?("USD") }
            puts "Error: Invalid JSON structure for metals"
            puts "Expected format:"
            puts '{
  "data": {
    "rates": {
      "USD[CODE]": 1234.56,
      ...
    }
  }
}'
            exit
          end
        end

        # Load and validate config
        config = load_material_config(config_type)

        # Process import
        MaterialPriceImporter.new(json_data, config).import

        # Archive the file
        timestamp = Time.now.strftime('%Y%m%d_%H%M%S')
        archive_name = "#{config_type}_prices_#{timestamp}.json"
        FileUtils.mv(latest_file, archive_dir.join(archive_name))
        
        puts "Successfully imported and archived as #{archive_name}"
      rescue JSON::ParserError => e
        puts "Error: Invalid JSON format in file"
        puts "Please verify the file contains valid JSON data"
        puts "Details: #{e.message}"
        exit
      rescue => e
        puts "Error processing file: #{e.message}"
        puts e.backtrace
      end
    rescue => e
      puts "\nUnexpected error:"
      puts e.message
      puts e.backtrace
    end
  end

  private

  def load_material_config(type)
    config_path = Rails.root.join('config', 'material_types', "#{type}.json")
    unless File.exist?(config_path)
      puts "Error: Configuration file for #{type} not found at #{config_path}"
      puts "Expected location: #{config_path}"
      exit
    end

    begin
      config = JSON.parse(File.read(config_path))
      
      # Validate config structure
      unless config["type"] && config["base_unit"] && 
             config["category_name"] && config["conversions"] && 
             config["materials"]
        puts "Error: Invalid configuration file structure"
        puts "Expected format:"
        puts '{
  "type": "material_type",
  "base_unit": "unit",
  "category_name": "Category Name",
  "conversions": { ... },
  "materials": { ... }
}'
        exit
      end
      
      config
    rescue JSON::ParserError => e
      puts "Error: Invalid JSON format in config file"
      puts "Please verify the configuration file contains valid JSON"
      puts "Details: #{e.message}"
      exit
    end
  end
end 