require 'rails_helper'

RSpec.describe "accesskeys/new", :type => :view do
  before(:each) do
    assign(:accesskey, Accesskey.new(
      :client_id => "MyString",
      :client_secret => "MyString",
      :callback_url => "MyString",
      :source_url => "MyString"
    ))
  end

  it "renders new accesskey form" do
    render

    assert_select "form[action=?][method=?]", accesskeys_path, "post" do

      assert_select "input#accesskey_client_id[name=?]", "accesskey[client_id]"

      assert_select "input#accesskey_client_secret[name=?]", "accesskey[client_secret]"

      assert_select "input#accesskey_callback_url[name=?]", "accesskey[callback_url]"

      assert_select "input#accesskey_source_url[name=?]", "accesskey[source_url]"
    end
  end
end
