require 'rails_helper'

RSpec.describe Api::V2::ReviewController, :type => :controller do

  describe "GET flagged" do
    it "returns http success" do
      get :flagged
      expect(response).to have_http_status(:success)
    end
  end

end
