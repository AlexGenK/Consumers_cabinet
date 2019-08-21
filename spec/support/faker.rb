require 'rails_helper'

module Faker

  class Bank
    class << self
      def mfo
        351520
      end
    end
  end

  class Company
    class << self
      def edrpou
        32855961
      end
    end
  end
  
end