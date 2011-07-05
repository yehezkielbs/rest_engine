Factory.define :sale do |f|
  f.sequence(:name) { |n| "Sale #{n}" }
  f.sequence(:address) { |n| "Address #{n}" }
  f.sale_date DateTime.now
end

Factory.define :toy, :class => Product::Toy do |f|
  f.sequence(:name) { |n| "Toy #{n}" }
  f.sequence(:description) { |n| "Description #{n}" }
end
