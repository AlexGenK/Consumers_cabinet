require 'rails_helper'

RSpec.describe Payment, type: :model do

  subject { build(:payment) }

  it "is valid with valid attributes", :focus do
    expect(subject).to be_valid
  end

end
