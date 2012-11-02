require 'minitest/autorun'
require_relative 'bowling'

class TestBowling < MiniTest::Unit::TestCase
  def setup
    @bowling = Bowling.new
  end

  def test_score_thru_given_frame
    @bowling.hit 5
    @bowling.hit 3
    @bowling.hit 7
    @bowling.hit 2
    @bowling.hit 3

    assert_equal 17, @bowling.score(2)
  end

  def test_total_for_all_gutters
    20.times do
      @bowling.hit 0
    end
    assert_equal 0, @bowling.score
  end

  def test_open_frame
    @bowling.hit 3
    @bowling.hit 6

    assert_equal 9, @bowling.score(1)
  end

  def test_spare_frame
    @bowling.hit 7
    @bowling.hit 3
    @bowling.hit 4

    assert_equal 14, @bowling.score(1)
  end

  def test_total_for_open_frame_after_spare
    @bowling.hit 7
    @bowling.hit 3
    @bowling.hit 4
    @bowling.hit 2

    assert_equal 20, @bowling.score
  end

  def test_total_for_open_frame_after_strike
    @bowling.hit 10
    @bowling.hit 3
    @bowling.hit 6

    assert_equal 28, @bowling.score
  end

  def test_two_consecutive_stikes
    @bowling.hit 10
    @bowling.hit 10
    @bowling.hit 3

    assert_equal 23, @bowling.score(1)
  end

  def test_four_consecutive_strikes
    @bowling.hit 10
    @bowling.hit 10
    @bowling.hit 10
    @bowling.hit 10

    assert_equal 30, @bowling.score(1)
    assert_equal 60, @bowling.score(2)
  end

  def test_a_perfect_game
    12.times do
      @bowling.hit 10
    end
    assert_equal 300, @bowling.score
  end

  def test_total_for_my_best_game
    @bowling.hit 10
    @bowling.hit 10
    @bowling.hit 10
    @bowling.hit 10
    @bowling.hit 10
    @bowling.hit 7
    @bowling.hit 3
    @bowling.hit 10
    @bowling.hit 9
    @bowling.hit 0
    @bowling.hit 8
    @bowling.hit 0
    @bowling.hit 8
    @bowling.hit 1

    assert_equal 202, @bowling.score
  end
end
