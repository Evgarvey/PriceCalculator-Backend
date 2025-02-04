class MaterialPriceImporter
  def initialize(json_data, config)
    @data = JSON.parse(json_data)
    @rates = @data["data"]["rates"]
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
    usd_prices = @rates.select { |key, _| key.start_with?("USD") }
    
    usd_prices.each do |code, price|
      material_code = code[3..-1]
      next unless @materials.key?(material_code)
      
      material_info = @materials[material_code]
      process_material(material_code, price, material_info)
    end
  end

  def process_material(code, price, material_info)
    category = MaterialCategory.find_or_create_by!(
      name: @config["category_name"],
      base_unit: @config["base_unit"]
    )

    material = Material.create!(
      name: material_info["name"],
      material_category: category
    )

    converted_price = convert_to_base_unit(price, material_info["unit"])

    Price.create!(
      material: material,
      price_per_unit: converted_price
    )
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