# Admin login: admin@assiniboine.test / password123  (change this after first login)
admin = AdminUser.find_or_initialize_by(email: "admin@assiniboine.test")
admin.password = "password123"
admin.save!

# Canadian tax rates. Verify against current CRA/provincial rates before marking.
[
  ["AB", "Alberta", 0.05, 0, 0],
  ["BC", "British Columbia", 0.05, 0.07, 0],
  ["MB", "Manitoba", 0.05, 0.07, 0],
  ["NB", "New Brunswick", 0, 0, 0.15],
  ["NL", "Newfoundland and Labrador", 0, 0, 0.15],
  ["NS", "Nova Scotia", 0, 0, 0.15],
  ["NT", "Northwest Territories", 0.05, 0, 0],
  ["NU", "Nunavut", 0.05, 0, 0],
  ["ON", "Ontario", 0, 0, 0.13],
  ["PE", "Prince Edward Island", 0, 0, 0.15],
  ["QC", "Quebec", 0.05, 0.09975, 0],
  ["SK", "Saskatchewan", 0.05, 0.06, 0],
  ["YT", "Yukon", 0.05, 0, 0]
].each do |code, name, gst, pst, hst|
  Province.find_or_create_by!(code: code) do |p|
    p.name = name
    p.gst = gst
    p.pst = pst
    p.hst = hst
  end
end

categories = {
  "Jackets" => "Hiking, rain and winter jackets.",
  "Footwear" => "Hiking boots and trail runners.",
  "Sleeping Gear" => "Sleeping bags and pads.",
  "Tents and Shelter" => "Tents and tarps.",
  "Ski Equipment" => "Cross-country and downhill ski gear."
}
categories.each do |name, description|
  Category.find_or_create_by!(name: name) { |c| c.description = description }
end

products = [
  ["Trail Pro Hiking Jacket", "Jackets", "ATO-JK-001", 189.99, 20, "Waterproof, breathable shell with taped seams for wet spring trails."],
  ["Winter Insulated Parka", "Jackets", "ATO-JK-002", 329.00, 12, "Insulated parka rated to -30 C with a hood and storm cuffs."],
  ["Trailhead Hiking Boots", "Footwear", "ATO-FW-001", 159.95, 18, "Leather mid-cut boots with a grippy outsole and ankle support."],
  ["Lakeshore Trail Runners", "Footwear", "ATO-FW-002", 124.50, 25, "Lightweight trail runners with quick-drying mesh uppers."],
  ["Summit 0 C Sleeping Bag", "Sleeping Gear", "ATO-SG-001", 219.00, 15, "Synthetic-fill mummy bag comfortable to 0 C."],
  ["Prairie Sleeping Pad", "Sleeping Gear", "ATO-SG-002", 69.99, 30, "Inflatable sleeping pad with an R-value of 3.5."],
  ["Two-Person Backpacking Tent", "Tents and Shelter", "ATO-TS-001", 299.99, 10, "Freestanding three-season tent that packs down to 2 kg."],
  ["Rainfly Tarp 3x3", "Tents and Shelter", "ATO-TS-002", 49.95, 40, "Ripstop nylon tarp with corner grommets for shelter setups."],
  ["Nordic Cross-Country Ski Set", "Ski Equipment", "ATO-SK-001", 449.00, 8, "Classic cross-country skis, bindings and poles for groomed trails."],
  ["Alpine Downhill Ski Boots", "Ski Equipment", "ATO-SK-002", 379.00, 6, "Stiff-flex alpine boots with a heat-moldable liner."]
]
products.each do |name, category, sku, price, stock, description|
  Product.find_or_create_by!(sku: sku) do |p|
    p.name = name
    p.category = Category.find_by!(name: category)
    p.price = price
    p.stock_quantity = stock
    p.description = description
    p.active = true
  end
end
