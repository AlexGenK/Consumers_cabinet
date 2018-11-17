require 'rails_helper'

RSpec.describe CurrentConsumption, type: :model do
  subject { build(:current_consumption) }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end
end
