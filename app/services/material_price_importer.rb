class MaterialPriceImporter
  def initialize(json_data, config)
    @data = JSON.parse(json_data)
    @rates = @data["conversion_rates"] || @data["data"]["rates"]  # Handle both formats
    @config = config
    @conversions = config["conversions"]
    @materials = config["materials"]
    @json_data = json_data
    @category = MaterialCategory.find_by(name: config["category_name"])
  end

  def import
    category = MaterialCategory.find_or_create_by!(
      name: @config["category_name"],
      base_unit: @config["base_unit"]
    )

    puts "Clearing old #{@config['category_name']} data..."
    Material.where(material_category: category).destroy_all
    
    puts "\nImporting new prices..."
    process_prices
    
    puts "\nImport completed."
    display_prices
  end

  private

  def process_prices
    # For currencies, we don't need the USD prefix
    if @config["type"] == "currency"
      @rates.each do |code, price|
        next unless @materials.key?(code)
        material_info = @materials[code]
        process_material(code, price, material_info)
      end
    else
      # Original logic for other materials
      usd_prices = @rates.select { |key, _| key.start_with?("USD") }
      usd_prices.each do |code, price|
        material_code = code[3..-1]
        next unless @materials.key?(material_code)
        material_info = @materials[material_code]
        process_material(material_code, price, material_info)
      end
    end
  end

  def process_material(code, price_value, material_info)
    # Handle different material types
    material_name = if @config["type"] == "currency"
      @materials[code]  # Use currency name from config
    else
      material_info    # Use existing logic for metals
    end

    # Find or create the material by name
    material = Material.find_or_create_by!(
      name: material_name,
      material_category: @category
    )

    # Create or update the price
    price = Price.find_or_initialize_by(material: material)
    price.update!(
      price_per_unit: price_value  # Only update price_per_unit
    )

    puts "Imported #{material.name}: #{price_value} per #{@config['base_unit']}"
  rescue => e
    puts "Error importing #{material_name}: #{e.message}"
  end

  def convert_to_base_unit(price, unit)
    conversion_factor = @conversions[unit]
    price / conversion_factor
  end

  def display_prices
    puts "\nCurrent #{@config['category_name']} Prices:"
    puts "----------------------------------------"
    puts "Material             |  Price per #{@config['base_unit']}"
    puts "----------------------------------------"

    # Join with material_categories and prices tables
    Material.joins(:material_category, :price)
           .where(material_categories: { name: @config["category_name"] })
           .order(:name)
           .each do |material|
      puts sprintf("%-20s| %10.2f", material.name, material.price.price_per_unit)
    end
    puts "----------------------------------------"  # Added footer line
    puts #newline because I am a fan of spacing
  end
end 