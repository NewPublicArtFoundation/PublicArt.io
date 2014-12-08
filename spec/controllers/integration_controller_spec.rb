require 'rails_helper'

RSpec.describe IntegrationController, :type => :controller do

  describe "GET 'instagram'" do
    it "returns http success" do
      get 'instagram'
      expect(response).to be_success
    end
  end

  describe "GET 'flickr'" do
    it "returns http success" do
      get 'flickr'
      expect(response).to be_success
    end
  end

end
