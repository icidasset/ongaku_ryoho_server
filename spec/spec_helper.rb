ENV["RACK_ENV"] = "test"

require File.expand_path("../../lib/ongaku_ryoho_server", __FILE__)
require "minitest/autorun"
require "rack/test"


class MiniTest::Spec
  include Rack::Test::Methods

  def app
    OngakuRyohoServer::Application
  end
end
