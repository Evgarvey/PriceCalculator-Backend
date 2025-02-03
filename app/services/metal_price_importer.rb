class MetalPriceImporter
  METAL_NAMES = {
    "XAU" => "Gold",
    "XAG" => "Silver",
    "XPT" => "Platinum",
    "XPD" => "Palladium",
    "XCU" => "Copper",
    "XRH" => "Rhodium",
    "ALU" => "Aluminum",
    "ZNC" => "Zinc",
    "TIN" => "Tin",
    "BRASS" => "Brass",
    "BRONZE" => "Bronze",
    "INDIUM" => "Indium",
    "MG" => "Magnesium",
    "MO" => "Molybdenum",
    "OSMIUM" => "Osmium",
    "RHENIUM" => "Rhenium",
    "TUNGSTEN" => "Tungsten",
    "URANIUM" => "Uranium",
    "GALLIUM" => "Gallium",
    "IRD" => "Iridium",
    "IRON" => "Iron",
    "LEAD" => "Lead",
    "ND" => "Neodymium",
    "NI" => "Nickel",
    "RUTH" => "Ruthenium",
    "TE" => "Tellurium",
    "TITANIUM" => "Titanium",
    "DYS" => "Dysprosium",
    "GER" => "Germanium",
    "HAF" => "Hafnium",
    "LTH" => "Lanthanum",
    "PRA" => "Praseodymium",
    "TER" => "Terbium",
    "BMTH" => "Bismuth"
  }.freeze

  def initialize(json_data)
    @data = JSON.parse(json_data)
    @rates = @data["data"]["rates"]
  end

  def import
    puts "Clearing old data..."
    PreciousMaterialPrice.delete_all
    Material.delete_all
    
    puts "\nImporting new prices..."
    usd_metals = @rates.select { |key, _| key.start_with?("USD") }
    
    usd_metals.each do |code, price|
      metal_code = code[3..-1]
      next unless METAL_NAMES.key?(metal_code)  # Only process metals we have names for
      
      unit = case metal_code
      when "ALU", "ZNC", "LME-NI", "BRASS", "BRONZE", "INDIUM", "MG", "MO", "OSMIUM", "RHENIUM", "TUNGSTEN"
        "troy_ounce"
      when "URANIUM"
        "pound"
      else
        "ounce"
      end

      process_metal(metal_code, price, unit)
    end
    
    puts "\nImport completed. #{usd_metals.count} prices updated."
    display_prices
  end

  private

  def display_prices
    puts "\nCurrent Metal Prices:"
    puts "-" * 40
    puts "Metal".ljust(20) + " | " + "Price per Gram".rjust(15)
    puts "-" * 40

    Material.includes(:precious_material_price).order(:name).each do |material|
      price = material.precious_material_price&.price_per_gram
      puts "#{material.name.ljust(20)} | #{price ? sprintf('%15.6f', price) : 'No price'.rjust(15)}"
    end
    puts "-" * 40
  end

  def process_metal(code, price, unit)
    category = MaterialCategory.find_or_create_by!(name: "Metals", base_unit: "gram")
    metal_name = METAL_NAMES[code]  # No fallback to titleize

    return unless metal_name  # Skip if no mapping exists

    material = Material.create!(
      name: metal_name,
      material_category: category
    )

    price_per_gram = convert_to_price_per_gram(price, unit)

    PreciousMaterialPrice.create!(
      material: material,
      price_per_gram: price_per_gram
    )
  end

  def convert_to_price_per_gram(price, unit)
    case unit
    when "troy_ounce"
      price / 31.1035  # Troy ounces to grams
    when "ounce"
      price / 28.3495  # Ounces to grams
    when "pound"
      price / 453.592  # Pounds to grams
    else
      price
    end
  end
end 