require 'rails_helper'

module Faker

  class Bank
    MFO = [307770, 380946, 380548, 322302, 380634, 380894, 320940, 300346, 300119, 322335, 353489, 380645, 380281, 380913, 
           321723, 307123, 380526, 351607, 380827, 380731, 377090, 305880, 336310, 300539, 313849, 300647, 312248, 322540, 
           307350, 300614, 305749, 380366, 380441, 325365, 339050, 325268, 351629, 380582, 313582, 328760, 322001, 313009, 
           325990, 300528, 300465, 300506, 328209, 300658, 353100, 331489, 339016, 380838, 305299, 320984, 300012, 334851, 
           306500, 300335, 344443, 339072, 320627, 380797, 300584, 380816, 351254, 339500, 380106, 380883, 320371, 320478, 
           351005, 300023, 380377, 322313, 322001, 334840, 380872, 380418, 322539]

    class << self
      def mfo
        MFO.sample
      end
    end
  end

  class Company
    class << self
      def edrpou
        edrpou_keyless=[]
        edrpou_keyless << rand(1..9)
        6.times { edrpou_keyless << rand(0..9) }
        edrpou_keyless << edrpou_keygen(edrpou_keyless)
        edrpou_keyless.reduce{|n, d| n * 10 + d}
      end

      def edrpou_check(value)
        edrpou_keygen(value.to_s.chars.map(&:to_i)[0..6]) == value.to_s.chars.map(&:to_i)[7]
      end

      private

      def weight_sum(value, weight)
        sum = 0
        value.each_with_index do |val, i|
          sum = sum + val * weight[i]
        end
        sum
      end

      def edrpou_keygen(edrpou_keyless)
        if (edrpou_keyless[0] > 2) && (edrpou_keyless[0] < 6)
          weight = [[7, 1, 2, 3, 4, 5, 6], [9, 3, 4, 5, 6, 7, 8]]
        else
          weight = [[1, 2, 3, 4, 5, 6, 7], [3, 4, 5, 6, 7, 8, 9]]
        end

        sum = weight_sum(edrpou_keyless, weight[0])
        if (sum % 11) > 9
          sum = weight_sum(edrpou_keyless, weight[1])
        end
        sum % 11
      end
    end
  end
  
end