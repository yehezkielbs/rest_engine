class CreateToys < ActiveRecord::Migration
  def self.up
    create_table :toys do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :toys
  end
end
