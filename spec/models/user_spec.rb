require 'rails_helper'

RSpec.describe User, type: :model do
  it "is valid with email and password" do
    user = User.new(email: "bruce@batman.com", password: "password123", password_confirmation: "password123")
    expect(user).to be_valid
  end

  it "is invalid without email" do
    user = User.new(password: "password123", password_confirmation: "password123")
    expect(user).not_to be_valid
  end

  it "is invalid with unmatched password" do
    user = User.new(email: "burce@batman.com", password:"123", password_confirmation:"12345")
    expect(user).not_to be_valid
  end

end
