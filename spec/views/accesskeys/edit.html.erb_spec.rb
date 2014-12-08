require 'rails_helper'

RSpec.describe "accesskeys/edit", :type => :view do
  before(:each) do
    @accesskey = assign(:accesskey, Accesskey.create!(
      :client_id => "MyString",
      :client_secret => "MyString",
      :callback_url => "MyString",
      :source_url => "MyString"
    ))
  end

  it "renders the edit accesskey form" do
    render

    assert_select "form[action=?][method=?]", accesskey_path(@accesskey), "post" do

      assert_select "input#accesskey_client_id[name=?]", "accesskey[client_id]"

      assert_select "input#accesskey_client_secret[name=?]", "accesskey[client_secret]"

      assert_select "input#accesskey_callback_url[name=?]", "accesskey[callback_url]"

      assert_select "input#accesskey_source_url[name=?]", "accesskey[source_url]"
    end
  end
end
