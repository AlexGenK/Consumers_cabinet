require 'rails_helper'

RSpec.describe Power, type: :model do
  subject { build(:power) }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid with negative active energy values" do
    subject.before_active = -100
    expect(subject).to_not be_valid
  end

  it "is not valid with negative reactive energy values" do
    subject.before_reactive = -100
    expect(subject).to_not be_valid
  end

  it "is not valid with negative generation energy values" do
    subject.before_generation = -100
    expect(subject).to_not be_valid
  end

  it "is not valid when active energy values now, less than before" do
    subject.active = subject.before_active - 1
    expect(subject).to_not be_valid
  end

  it "is not valid when reactive energy values now, less than before" do
    subject.reactive = subject.before_reactive - 1
    expect(subject).to_not be_valid
  end

  it "is not valid when generation energy values now, less than before" do
    subject.generation = subject.before_generation - 1
    expect(subject).to_not be_valid
  end
end