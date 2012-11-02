require 'minitest/autorun'
require_relative 'frame'

class TestFrame < MiniTest::Unit::TestCase
  def setup
    @frame = Bowling::Frame.new
  end

  def test_sets_proper_roll
    @frame.rolled(4)

    assert_equal 4, @frame.first_roll
    assert_equal Bowling::Frame::NotRolled, @frame.second_roll

    refute @frame.complete?, "frame improperly complete"

    @frame.rolled(5)
    assert_equal 4, @frame.first_roll
    assert_equal 5, @frame.second_roll

    assert @frame.complete?, "frame not complete"

    assert_raises Bowling::Frame::InvalidRoll do
      @frame.rolled(9)
    end
  end

  def test_knows_total_pins_hit
    assert_equal 0, @frame.total_pins_hit

    @frame.rolled(4)
    @frame.rolled(5)

    assert_equal 9, @frame.total_pins_hit
  end

  def test_knows_it_is_a_strike
    @frame.rolled(10)

    assert @frame.strike?, "not a strike"
    refute @frame.spare?, "invalid spare"
  end

  def test_strike_cant_roll_second_roll
    @frame.rolled(10)

    assert_raises Bowling::Frame::InvalidRoll do
      @frame.rolled(1)
    end
  end

  def test_cant_roll_more_than_total_number_of_pins
    assert_raises Bowling::Frame::InvalidRoll do
      @frame.rolled(22)
    end

    @frame.rolled(5)
    assert_raises Bowling::Frame::InvalidRoll do
      @frame.rolled(6)
    end
  end

  def test_knows_number_of_pins_left
    assert_equal 10, @frame.pins_left

    @frame.rolled(5)
    assert_equal 5, @frame.pins_left

    @frame.rolled(4)
    assert_equal 1, @frame.pins_left
  end
end
