require 'rails_helper'

RSpec.describe Payment, type: :model do

  subject { build(:payment) }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid with empty company" do
    subject.company = nil
    expect(subject).to_not be_valid
  end

  it "is not valid with empty EDRPOU" do
    subject.edrpou = nil
    expect(subject).to_not be_valid
  end

  it "is not valid with empty account" do
    subject.account = nil
    expect(subject).to_not be_valid
  end

  it "is not valid with empty bank" do
    subject.bank = nil
    expect(subject).to_not be_valid
  end

  it "is not valid with empty MFO" do
    subject.mfo = nil
    expect(subject).to_not be_valid
  end

  it "is not valid with MFO less than 6 digits" do
    subject.mfo = 12345
    expect(subject).to_not be_valid
  end

  it "is not valid with MFO more than 6 digits" do
    subject.mfo = 1234567
    expect(subject).to_not be_valid
  end

  it "is not valid with EDRPOU less than 8 digits" do
    subject.edrpou = 1234567
    expect(subject).to_not be_valid
  end

  it "is not valid with EDRPOU more than 8 digits" do
    subject.edrpou = 123456789
    expect(subject).to_not be_valid
  end

end
