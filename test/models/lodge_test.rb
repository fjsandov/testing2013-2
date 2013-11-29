require 'test_helper'

class LodgeTest < ActiveSupport::TestCase
  test 'average_quality_range' do
    lodge = Lodge.first
    average_quality = lodge.average_quality
    if lodge.comments.size != 0
      assert (average_quality >= 1 and average_quality <= 5),
             "average quality must be between 1 and 5 but is #{average_quality}"
    else
      assert average_quality == 0, 'average quality must be 0 because lodge does not have comments'
    end
  end

  test 'average_price_range' do
    lodge = Lodge.first
    average_price = lodge.average_price
    if lodge.comments.size != 0
      assert (average_price >= 1 and average_price <= 5),
             "average price must be between 1 and 5 but is #{average_price}"
    else
      assert average_price == 0, 'average price must be 0 because lodge does not have comments'
    end
  end

  test 'average_price' do
    lodge = Lodge.create(name: 'test lodge 1')
    Comment.create(lodge_id: lodge.id, quality: 3, price: 2)
    Comment.create(lodge_id: lodge.id, quality: 5, price: 3)
    Comment.create(lodge_id: lodge.id, quality: 5, price: 4)
    avg_price = (((2+3+4)/3.to_f)*100).round / 100.to_f
    assert lodge.average_price == avg_price, "average price must be #{avg_price} and is #{lodge.average_price}"
  end

  test 'average_quality' do
    lodge = Lodge.create(name: 'test lodge 2')
    Comment.create(lodge_id: lodge.id, quality: 3, price: 2)
    Comment.create(lodge_id: lodge.id, quality: 5, price: 3)
    Comment.create(lodge_id: lodge.id, quality: 5, price: 4)
    avg_quality = (((3+5+5)/3.to_f)*100).round / 100.to_f
    assert lodge.average_quality == avg_quality, "average quality must be #{avg_quality} and is #{lodge.average_quality}"
  end

end
