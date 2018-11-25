class Contract < ApplicationRecord
  has_many :counters, dependent: :destroy
end
