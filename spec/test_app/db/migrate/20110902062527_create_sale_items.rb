class CreateSaleItems < ActiveRecord::Migration
  def self.up
    create_table :sale_items do |t|
      t.references :sale
      t.string :name
      t.integer :qty

      t.timestamps
    end
  end

  def self.down
    drop_table :sale_items
  end
end
