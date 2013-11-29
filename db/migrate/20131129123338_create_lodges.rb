class CreateLodges < ActiveRecord::Migration
  def change
    create_table :lodges do |t|
      t.string :name
      t.float :lat
      t.float :long
      t.string :category

      t.timestamps
    end
  end
end
