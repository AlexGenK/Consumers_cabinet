require 'rails_helper'

module Faker
  class Bank
    MFO = [307_770, 380_946, 380_548, 322_302, 380_634, 380_894, 320_940, 300_346, 300_119, 322_335, 353_489, 380_645,
           380_281, 380_913, 321_723, 307_123, 380_526, 351_607, 380_827, 380_731, 377_090, 305_880, 336_310, 300_539,
           313_849, 300_647, 312_248, 322_540, 307_350, 300_614, 305_749, 380_366, 380_441, 325_365, 339_050, 325_268,
           351_629, 380_582, 313_582, 328_760, 322_001, 313_009, 325_990, 300_528, 300_465, 300_506, 328_209, 300_658,
           353_100, 331_489, 339_016, 380_838, 305_299, 320_984, 300_012, 334_851, 306_500, 300_335, 344_443, 339_072,
           320_627, 380_797, 300_584, 380_816, 351_254, 339_500, 380_106, 380_883, 320_371, 320_478, 351_005, 300_023,
           380_377, 322_313, 322_001, 334_840, 380_872, 380_418, 322_539].freeze

    class << self
      def mfo
        MFO.sample
      end
    end
  end

  class Company
    class << self
      def edrpou
        edrpou_keyless = []
        edrpou_keyless << rand(1..9)
        6.times { edrpou_keyless << rand(0..9) }
        edrpou_keyless << edrpou_keygen(edrpou_keyless)
        edrpou_keyless.reduce { |n, d| n * 10 + d }
      end

      def edrpou_check(value)
        edrpou_keygen(value.to_s.chars.map(&:to_i)[0..6]) == value.to_s.chars.map(&:to_i)[7]
      end

      private

      def weight_sum(value, weight)
        sum = 0
        value.each_with_index do |val, i|
          sum += val * weight[i]
        end
        sum
      end

      def edrpou_keygen(edrpou_keyless)
        weight = if (edrpou_keyless[0] > 2) && (edrpou_keyless[0] < 6)
                   [[7, 1, 2, 3, 4, 5, 6], [9, 3, 4, 5, 6, 7, 8]]
                 else
                   [[1, 2, 3, 4, 5, 6, 7], [3, 4, 5, 6, 7, 8, 9]]
                 end

        sum = weight_sum(edrpou_keyless, weight[0])
        sum = weight_sum(edrpou_keyless, weight[1]) if (sum % 11) > 9
        sum % 11
      end
    end
  end
end
