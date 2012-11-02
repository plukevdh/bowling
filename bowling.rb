require_relative 'linked_list'
require_relative 'frame'

class Bowling < LinkedList
  module ScoreCalculator
    class << self
      def calculate(frames)
        total = 0

        frames.each do |frame|
          total += if frame.strike?
            frame.total_pins_hit + next_two_rolls_from(frame)
          elsif frame.spare?
            frame.total_pins_hit + next_roll_from(frame)
          else
            frame.total_pins_hit
          end
        end

        total
      end

      private
      def next_roll_from(frame)
        frame.next.first_roll
      end

      def next_two_rolls_from(frame)
        next_frame = frame.next

        if next_frame.strike?
          Bowling::Frame::MAX_PINS + next_roll_from(next_frame)
        else
          next_frame.frame_total
        end
      end
    end
  end


  def initialize
    super
    start_next_frame
  end

  def hit(pins)
    @current_frame.rolled(pins)

    start_next_frame if @current_frame.complete?
  end

  def score(to_frame=10)
    ScoreCalculator.calculate sublist(to_frame)
  end

  private

  def start_next_frame
    @current_frame = Frame.new
    insert_node(@current_frame)
  end
end