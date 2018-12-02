require 'rails_helper'

RSpec.describe Contract, type: :model do
  subject { build(:contract) }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end
end
