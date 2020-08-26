require "minitest/autorun"
require "minitest/pride"
require "./lib/room"
require "./lib/house"

class HouseTest < Minitest::Test
  def test_it_exists
    house = House.new("$400000", "123 sugar lane")

    assert_instance_of House, house
  end

  def test_it_has_attributes
    house = House.new("$400000", "123 sugar lane")

    assert_equal 400000, house.price
    assert_equal "123 sugar lane", house.address
  end

  def test_house_can_have_rooms
    house = House.new("$400000", "123 sugar lane")
    room_1 = Room.new(:bedroom, 10, '13')
    room_2 = Room.new(:bedroom, 11, '15')

    house.add_room(room_1)
    house.add_room(room_2)

    assert_equal [room_1, room_2], house.rooms
  end

  def test_check_if_house_is_above_market_average
    house_1 = House.new("$400000", "123 sugar lane")
    house_2 = House.new("$600000", "2828 main street")

    assert_equal false, house_1.above_market_average?
    assert house_2.above_market_average?
  end

  def test_can_see_rooms_by_category
    house = House.new("$400000", "123 sugar lane")
    room_1 = Room.new(:bedroom, 10, "13")
    room_2 = Room.new(:bedroom, 11, "15")
    room_3 = Room.new(:living_room, 25, "15")
    room_4 = Room.new(:basement, 30, "41")

    house.add_room(room_1)
    house.add_room(room_2)
    house.add_room(room_3)
    house.add_room(room_4)

    assert_equal [room_1, room_2], house.rooms_from_category(:bedroom)
    assert_equal [room_4], house.rooms_from_category(:basement)
  end

  def test_get_house_area
    house = House.new("$400000", "123 sugar lane")
    room_1 = Room.new(:bedroom, 10, "13")
    room_2 = Room.new(:bedroom, 11, "15")
    room_3 = Room.new(:living_room, 25, "15")
    room_4 = Room.new(:basement, 30, "41")

    house.add_room(room_1)
    house.add_room(room_2)
    house.add_room(room_3)
    house.add_room(room_4)

    assert_equal 1900, house.area
  end

  def test_can_see_house_details
    house = House.new("$400000", "123 sugar lane")

    expected = {"price" => 400000, "address" => "123 sugar lane"}

    assert_equal expected, house.details
  end

  def test_see_price_per_square_foot
    house = House.new("$400000", "123 sugar lane")
    room_1 = Room.new(:bedroom, 10, "13")
    room_2 = Room.new(:bedroom, 11, "15")
    room_3 = Room.new(:living_room, 25, "15")
    room_4 = Room.new(:basement, 30, "41")

    house.add_room(room_4)
    house.add_room(room_1)
    house.add_room(room_3)
    house.add_room(room_2)

    assert_equal 210.53, house.price_per_square_foot
  end
end
