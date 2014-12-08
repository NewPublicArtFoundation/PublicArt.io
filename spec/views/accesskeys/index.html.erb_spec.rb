require 'rails_helper'

RSpec.describe "accesskeys/index", :type => :view do
  before(:each) do
    assign(:accesskeys, [
      Accesskey.create!(
        :client_id => "Client",
        :client_secret => "Client Secret",
        :callback_url => "Callback Url",
        :source_url => "Source Url"
      ),
      Accesskey.create!(
        :client_id => "Client",
        :client_secret => "Client Secret",
        :callback_url => "Callback Url",
        :source_url => "Source Url"
      )
    ])
  end

  it "renders a list of accesskeys" do
    render
    assert_select "tr>td", :text => "Client".to_s, :count => 2
    assert_select "tr>td", :text => "Client Secret".to_s, :count => 2
    assert_select "tr>td", :text => "Callback Url".to_s, :count => 2
    assert_select "tr>td", :text => "Source Url".to_s, :count => 2
  end
end
