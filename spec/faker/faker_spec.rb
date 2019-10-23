require 'rails_helper'

describe 'Faker::Bank.mfo' do
  subject(:mfo) { Faker::Bank.mfo }
  it 'give correct MFO code' do
    expect(mfo.to_s[0]).to eq '3'
    expect(mfo.to_s.size).to eq 6
  end
end

describe 'Faker::Company.edrpou' do
  subject(:edrpou) { Faker::Company.edrpou }
  it 'give correct EDRPOU code' do
    expect(Faker::Company.edrpou_correct?(edrpou)).to be true
  end
end

RSpec.describe 'Faker::Company.edrpou_correct?' do
  it 'check EDRPOU code' do
    expect(Faker::Company.edrpou_correct?(38000735)).to be true
    expect(Faker::Company.edrpou_correct?(38234176)).to be true
    expect(Faker::Company.edrpou_correct?(38000736)).to be false
    expect(Faker::Company.edrpou_correct?(58234173)).to be false
  end
end
