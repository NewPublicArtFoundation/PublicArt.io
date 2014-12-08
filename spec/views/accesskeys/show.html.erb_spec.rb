require 'rails_helper'

RSpec.describe "accesskeys/show", :type => :view do
  before(:each) do
    @accesskey = assign(:accesskey, Accesskey.create!(
      :client_id => "Client",
      :client_secret => "Client Secret",
      :callback_url => "Callback Url",
      :source_url => "Source Url"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Client/)
    expect(rendered).to match(/Client Secret/)
    expect(rendered).to match(/Callback Url/)
    expect(rendered).to match(/Source Url/)
  end
end
