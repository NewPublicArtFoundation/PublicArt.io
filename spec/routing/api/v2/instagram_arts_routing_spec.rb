require "rails_helper"

RSpec.describe Api::V2::InstagramArtsController, :type => :routing do
  describe "routing" do

    it "routes to #indexlocation" do
      expect(:get => "/api/find").to route_to("api/v2/instagram_arts#indexlocation", format: 'json')
    end

  end
end
