class Contract < ApplicationRecord
  has_many :counters, dependent: :destroy
  belongs_to :consumer
end
