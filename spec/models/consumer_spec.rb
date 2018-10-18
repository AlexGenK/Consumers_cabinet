require 'rails_helper'

RSpec.describe Consumer, type: :model do
  subject { build(:consumer) }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid with empty name" do
    subject.name = ''
    expect(subject).to_not be_valid
  end

  it "is not valid with empty 1C Id" do
    subject.onec_id = ''
    expect(subject).to_not be_valid
  end

  it "is not valid when name is not unique" do
    create(:consumer, onec_id: 124)
    expect(subject).to_not be_valid
  end

  it "is not valid when 1C Id is not unique" do
    create(:consumer, name: 'ЧП Попкин С.В.')
    expect(subject).to_not be_valid
  end
end
