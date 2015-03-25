require 'rails_helper'

RSpec.describe PagesController, :type => :controller do

  describe "GET 'home_web'" do
    it "returns http success" do
      get 'home_web'
      expect(response).to be_success
    end
  end

end
