class AddAddressToLodges < ActiveRecord::Migration
  def change
    add_column :lodges, :address, :string
  end
end
