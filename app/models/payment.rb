class Payment < ApplicationRecord
	validates :company, presence: true
	validates :edrpou, 	presence: true, length: { is: 8 }
	validates :account, presence: true, this_is_iban: true
	validates :bank, 		presence: true
	validates :mfo, 		presence: true, length: { is: 6 }
end
