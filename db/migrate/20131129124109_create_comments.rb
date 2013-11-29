class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :quality
      t.float :price
      t.string :message
      t.string :email
      t.references :lodge, index: true

      t.timestamps
    end
  end
end
