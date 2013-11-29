class Lodge < ActiveRecord::Base
  has_many :comments

  def average_quality
    avg_quality = 0
    count = 0
    self.comments.each do |comment|
      avg_quality += comment.quality
      count += 1
    end
    count == 0 ? 0 : ((avg_quality/count.to_f)*100).round / 100.to_f
  end


  def average_price
    avg_price = 0
    count = 0
    self.comments.each do |comment|
      avg_price += comment.price
      count += 1
    end
    count == 0 ? 0 : ((avg_price/count.to_f)*100).round / 100.to_f
  end
end
