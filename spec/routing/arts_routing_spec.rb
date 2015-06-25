require "rails_helper"

RSpec.describe Api::V2::ArtsController, :type => :routing do
  describe "routing" do

    it "routes to #geojson_total" do
      expect(:get => "/api/geojson/total").to route_to("api/v2/arts#geojson_total", format: 'json')
    end

    it "routes to #geojson" do
      expect(:get => "/api/geojson/:id").to route_to("api/v2/arts#geojson", :id => "1", format: 'json')
    end

  end
end
