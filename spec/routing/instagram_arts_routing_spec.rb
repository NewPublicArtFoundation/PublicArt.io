require "rails_helper"

RSpec.describe Api::V2::InstagramArtsController, :type => :routing do
  describe "routing" do

    it "routes to #indexlocation" do
      expect(:get => "/find").to route_to("web/v1/instagram_arts#indexlocation")
    end

  end
end
