require 'rails_helper'

RSpec.describe "Accesskeys", :type => :request do
  describe "GET /accesskeys" do
    it "works! (now write some real specs)" do
      get accesskeys_path
      expect(response.status).to be(200)
    end
  end
end
