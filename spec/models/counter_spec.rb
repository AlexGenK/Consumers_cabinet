require 'rails_helper'

RSpec.describe Counter, type: :model do
  subject { build(:counter) }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid with empty number" do
    subject.number = nil
    expect(subject).to_not be_valid
  end

  it "is not valid when ratio less than zero" do
    subject.ratio = -10
    expect(subject).to_not be_valid
  end
end
