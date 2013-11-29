require 'test_helper'

class LodgeTest < ActiveSupport::TestCase
  test 'average_quality_range' do
    lodge = Lodge.first
    average_quality = lodge.average_quality
    assert average_quality >= 1 and average_quality <= 5
  end

  test 'average_price_range' do
    lodge = Lodge.first
    average_price = lodge.average_price
    assert average_price >= 1 and average_price <= 5
  end

  test 'average_price' do
    lodge = Lodge.create(name: 'test lodge 1')
    Comment.create(lodge_id: lodge.id, quality: 3, price: 2)
    Comment.create(lodge_id: lodge.id, quality: 5, price: 3)
    Comment.create(lodge_id: lodge.id, quality: 5, price: 4)

    asset lodge.average_quality == (3+5+5)/3
  end

  test 'average_quality' do
    lodge = Lodge.create(name: 'test lodge 2')
    Comment.create(lodge_id: lodge.id, quality: 3, price: 2)
    Comment.create(lodge_id: lodge.id, quality: 5, price: 3)
    Comment.create(lodge_id: lodge.id, quality: 5, price: 4)
    assert lodge.average_price == (2+3+4)/3
  end

end
