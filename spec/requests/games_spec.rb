require 'rails_helper'

RSpec.describe "Games", type: :request do
  describe "GET /new" do
    it "returns http success" do
      get "/games/new"
      expect(response).to have_http_status(:success)
    end
  end

end
