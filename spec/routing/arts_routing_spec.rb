require "rails_helper"

RSpec.describe Api::V2::ArtsController, :type => :routing do
  describe "routing" do

    it "routes to #geojson_total" do
      expect(:get => "/geojson/total").to route_to("arts#geojson_total")
    end

    it "routes to #geojson" do
      expect(:get => "/geojson/:id").to route_to("arts#geojson")
    end

  end
end
