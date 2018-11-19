require 'rails_helper'

RSpec.describe User, type: :model do
  subject { build(:user_admin) }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid with a non-unique username" do
    create(:user_admin, email: ('other' + subject.email))
    expect(subject).to_not be_valid
  end

  it "is not valid with a non-unique email" do
    create(:user_admin, username: ('other' + subject.username))
    expect(subject).to_not be_valid
  end
end
