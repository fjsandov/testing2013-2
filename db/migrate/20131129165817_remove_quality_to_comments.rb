class RemoveQualityToComments < ActiveRecord::Migration
  def change
    remove_column :comments, :quality
  end
end
