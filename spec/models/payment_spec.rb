require 'rails_helper'

RSpec.describe Payment, type: :model do
  subject(:beneficiary_details) { build(:payment) }

  it 'is valid with valid attributes' do
    expect(beneficiary_details).to be_valid
  end

  it 'is not valid with empty company' do
    beneficiary_details.company = nil
    expect(beneficiary_details).not_to be_valid
  end

  it 'is not valid with empty EDRPOU' do
    beneficiary_details.edrpou = nil
    expect(beneficiary_details).not_to be_valid
  end

  it 'is not valid with empty account' do
    beneficiary_details.account = nil
    expect(beneficiary_details).not_to be_valid
  end

  it 'is not valid if the account length does not comply with the IBAN format' do
    beneficiary_details.account += '0'
    expect(beneficiary_details).not_to be_valid
  end

  it 'is not valid if the account numbers does not comply with the IBAN format' do
    beneficiary_details.account[10] = ((beneficiary_details.account[10].to_i + 1) % 10).to_s
    expect(beneficiary_details).not_to be_valid
  end

  it 'is not valid with empty bank' do
    beneficiary_details.bank = nil
    expect(beneficiary_details).not_to be_valid
  end

  it 'is not valid with empty MFO' do
    beneficiary_details.mfo = nil
    expect(beneficiary_details).not_to be_valid
  end

  it 'is not valid with MFO less than 6 digits' do
    beneficiary_details.mfo = 12_345
    expect(beneficiary_details).not_to be_valid
  end

  it 'is not valid with MFO more than 6 digits' do
    beneficiary_details.mfo = 1_234_567
    expect(beneficiary_details).not_to be_valid
  end

  it 'is not valid with EDRPOU less than 8 digits' do
    beneficiary_details.edrpou = 1_234_567
    expect(beneficiary_details).not_to be_valid
  end

  it 'is not valid with EDRPOU more than 8 digits' do
    beneficiary_details.edrpou = 123_456_789
    expect(beneficiary_details).not_to be_valid
  end
end
