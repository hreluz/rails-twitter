require 'rails_helper'

RSpec.describe "User login", type: :request do
    let!(:user) { User.create(email: "test@example.com", password: "password123", password_confirmation: "password123") }
  
    it "logs in with correct credentials" do
      post login_path, params: { email: "test@example.com", password: "password123" }
      expect(response).to redirect_to(root_path)
      follow_redirect!
      expect(response.body).to include("Logged in!")
    end
  
    it "fails with wrong password" do
      post login_path, params: { email: "test@example.com", password: "wrongpass" }
      expect(response.body).to include("Invalid email or password")
    end
  end