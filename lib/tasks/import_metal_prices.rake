namespace :metal_prices do
  desc "Import metal prices from JSON file"
  task import: :environment do
    # Directory settings
    data_dir = Rails.root.join('data', 'metal_prices')
    archive_dir = data_dir.join('archive')
    
    # Find the most recent JSON file
    json_files = Dir[data_dir.join('*.json')]
    if json_files.empty?
      puts "Error: No JSON files found in #{data_dir}"
      puts "Please place your JSON file in #{data_dir} directory"
      exit
    end

    latest_file = json_files.max_by { |f| File.mtime(f) }
    puts "Found file: #{latest_file}"
    
    begin
      # Check if file is empty
      if File.zero?(latest_file)
        puts "Error: File is empty"
        exit
      end

      # Read file and check JSON validity
      json_data = File.read(latest_file)
      begin
        JSON.parse(json_data) # Test parse before sending to importer
        puts "JSON format verified..."
      rescue JSON::ParserError => e
        puts "Error: Invalid JSON format"
        puts "Details: #{e.message}"
        puts "Please check that your JSON file is properly formatted"
        exit
      end

      # Process the file
      puts "Starting import..."
      importer = MetalPriceImporter.new(json_data)
      importer.import

      # Archive the file
      timestamp = Time.now.strftime('%Y%m%d_%H%M%S')
      archive_name = "metal_prices_#{timestamp}.json"
      FileUtils.mv(latest_file, archive_dir.join(archive_name))
      
      puts "Successfully imported and archived as #{archive_name}"
    rescue => e
      puts "\nError processing file:"
      puts "#{e.class}: #{e.message}"
      puts "\nBacktrace:"
      puts e.backtrace[0..5] # Show first 6 lines of backtrace
      puts "..."
    end
  end

  desc "Clean up old archived files"
  task cleanup: :environment do
    archive_dir = Rails.root.join('data', 'metal_prices', 'archive')
    # Keep last 30 days of archives
    old_files = Dir[archive_dir.join('*.json')].select do |file|
      File.mtime(file) < 30.days.ago
    end
    
    old_files.each do |file|
      FileUtils.rm(file)
      puts "Removed old archive: #{file}"
    end
  end
end 