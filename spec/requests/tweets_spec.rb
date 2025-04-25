require 'rails_helper'

RSpec.describe "Tweets", type: :request do
  # describe "GET /index" do
  #   it "returns http success" do
  #     get "/tweets/index"
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  # describe "GET /show" do
  #   it "returns http success" do
  #     get "/tweets/show"
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  describe "GET /create" do
    it "creates a twitter" do
      post login_path, params: { email: "test@example.com", password: "password123" }
      expect(response).to redirect_to(root_path)
      follow_redirect!
      expect(response.body).to include("Logged in!")
    end
    # it "returns http success" do
    #   get "/tweets/create"
    #   expect(response).to have_http_status(:success)
    # end
  end

end
