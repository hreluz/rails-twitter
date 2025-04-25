require 'rails_helper'

RSpec.describe Tweet, type: :model do

  let!(:user) { User.create(email: "test@example.com", password: "password123", password_confirmation: "password123") }

  it "is valid a user can create a tweet" do
    tweet = user.tweets.build(content: "my first tweet")
    expect(tweet).to be_valid
    expect(tweet.save).to be true
  end

  it "is not valid with an empty user and cannot create a tweet" do
    tweet = Tweet.new(content: "my first tweet")
    expect(tweet).not_to be_valid
    expect(tweet.save).to be false
  end
end
