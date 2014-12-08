require "rails_helper"

RSpec.describe AccesskeysController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/accesskeys").to route_to("accesskeys#index")
    end

    it "routes to #new" do
      expect(:get => "/accesskeys/new").to route_to("accesskeys#new")
    end

    it "routes to #show" do
      expect(:get => "/accesskeys/1").to route_to("accesskeys#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/accesskeys/1/edit").to route_to("accesskeys#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/accesskeys").to route_to("accesskeys#create")
    end

    it "routes to #update" do
      expect(:put => "/accesskeys/1").to route_to("accesskeys#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/accesskeys/1").to route_to("accesskeys#destroy", :id => "1")
    end

  end
end
