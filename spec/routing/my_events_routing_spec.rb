require "rails_helper"

RSpec.describe MyEventsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/my_events").to route_to("my_events#index")
    end

    it "routes to #autocomplete" do
      expect(:get => "/my_events/autocomplete").to route_to("my_events#autocomplete")
    end

    it "routes to #show" do
      expect(:get => "/my_events/1").to route_to("my_events#show", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/my_events").to route_to("my_events#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/my_events/1").to route_to("my_events#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/my_events/1").to route_to("my_events#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/my_events/1").to route_to("my_events#destroy", :id => "1")
    end

  end
end
