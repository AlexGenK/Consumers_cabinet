require 'rails_helper'

RSpec.describe PreviousConsumption, type: :model do
  subject { build(:previous_consumption) }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end
end
