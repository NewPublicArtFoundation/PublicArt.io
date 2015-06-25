require "rails_helper"

RSpec.describe Ios::V1::ArtsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/ios/v/").to route_to("ios/v1/arts#index")
    end

    it "routes to #show" do
      expect(:get => "/ios/v/").to route_to("ios/v1/arts#show", :id => "1")
    end

  end
end
