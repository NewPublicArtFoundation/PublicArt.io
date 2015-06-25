require 'rails_helper'

RSpec.describe ArtsController, :type => :controller do

  describe "GET show" do
    it "returns http success" do
      art = create(:instagram_art)
      get :show, id: art.id
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

end
