class AddQualityToComments < ActiveRecord::Migration
  def change
    add_column :comments, :quality, :float
  end
end
