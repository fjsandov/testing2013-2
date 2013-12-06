class Comment < ActiveRecord::Base
  belongs_to :lodge
  
  validates :message, :presence => true
  validates :email, :presence => true
  validates :price, :presence => true
  validates :quality, :presence => true
end
