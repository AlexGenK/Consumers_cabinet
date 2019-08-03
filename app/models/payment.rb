class Payment < ApplicationRecord
	validates :company, presence: true
	validates :edrpou, 	presence: true, length: 8
	validates :account, presence: true
	validates :bank, 		presence: true
	validates :mfo, 		presence: true, length: 6
end
