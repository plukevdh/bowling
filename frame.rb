require_relative 'linked_list'

class Bowling < LinkedList
  class Frame < LinkedList::Node

    class InvalidRoll < StandardError ; end
    NotRolled = Class.new

    MAX_PINS = 10

    def initialize
      super self
    end

    def rolled(pins_hit)
      raise InvalidRoll, "#{pins_hit} is greater than max number of pins (#{MAX_PINS})" if pins_hit > MAX_PINS
      raise InvalidRoll, "#{pins_hit} is greater than number of pins left (#{pins_left})" if pins_hit > pins_left

      if first_roll == NotRolled
        @first_roll = pins_hit
      elsif !strike? && second_roll == NotRolled
        @second_roll = pins_hit
      else
        raise InvalidRoll, 'all turns rolled for this frame'
      end
    end

    # special accessor methods
    %w(first_roll second_roll).each do |name|
      define_method name.to_sym do
        instance_variable_get("@#{name}".to_sym) || NotRolled
      end
    end

    def total_pins_hit
      return 0 if first_roll == NotRolled
      frame_total
    end

    def frame_total
      (strike? || second_roll == NotRolled) ? first_roll : first_roll + second_roll
    end

    def pins_left
      MAX_PINS - total_pins_hit
    end

    def strike?
      first_roll == MAX_PINS
    end

    def spare?
      second_roll != NotRolled && (first_roll + second_roll) == MAX_PINS
    end

    def complete?
      first_roll != NotRolled && (strike? || second_roll != NotRolled)
    end
  end
end