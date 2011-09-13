Factory.define :sale do |f|
  f.sequence(:name) { |n| "Sale #{n}" }
  f.sequence(:address) { |n| "Address #{n}" }
  f.sale_date DateTime.now
end

Factory.define :sale_item do |f|
  f.sequence(:name) { |n| "Sale Item #{n}" }
  f.qty 3
end

Factory.define :toy, :class => Product::Toy do |f|
  f.sequence(:name) { |n| "Toy #{n}" }
  f.sequence(:description) { |n| "Description #{n}" }
end

Factory.define(:sale_with_5_items, :parent => :sale) do |sale|
  sale.after_build do |s|
    s.sale_items = (1..5).map { Factory.create(:sale_item, :sale => s) }
  end
end