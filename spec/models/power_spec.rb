require 'rails_helper'

RSpec.describe Power, type: :model do
  subject { build(:power) }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end
end