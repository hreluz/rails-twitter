require 'rails_helper'

RSpec.describe "User auth", type: :request do
  
    describe "Login" do
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

    describe "register" do
      let!(:user) { User.create(email: "existed@example.com", password: "password123", password_confirmation: "password123") }
      
      it "creates a new user and redirects to root path" do
        expect {
          post register_path, params: {
            user: {
              email: "test@example.com",
              password: "password123",
              password_confirmation: "password123"
            }
          }
        }.to change(User, :count).by(1)

        expect(session[:user_id]).to eq(User.last.id)
        expect(response).to redirect_to(root_path)
        follow_redirect!
        expect(response.body).to include("Account created successfully")
      end
  
      it "does not create a user and re-renders the register page" do
        expect {
          post register_path, params: {
            user: {
              email: "",                      # Invalid
              password: "pass",
              password_confirmation: "mismatch"
            }
          }
        }.not_to change(User, :count)

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include("Register") # Assuming your view has "Register" title
      end

      it "does not allow to create an existing user" do
        expect {
          post register_path, params: {
            user: {
              email: "existed@example.com",      
              password: "password123",
              password_confirmation: "password123"
            }
          }
        }.not_to change(User, :count)

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include("Register") # Assuming your view has "Register" title
      end
    end
  end