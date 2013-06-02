require_relative "spec_helper"

describe "Application" do

  describe "GET index" do
    before do
      OngakuRyohoServer::List.save
      @list = OngakuRyohoServer::List.get
    end

    it "should return json" do
      get "/"
      last_response.must_be :ok?
      last_response.content_type.must_equal "application/json;charset=utf-8"
    end

    it "should return jsonp" do
      get "/", callback: "test"
      last_response.must_be :ok?
      last_response.content_type.must_equal "application/javascript;charset=utf-8"
    end
  end

end
