ENV["RACK_ENV"] = "test"

require_relative "../lib/ongaku_ryoho_server"
require "minitest/autorun"
require "rack/test"


class MiniTest::Spec
  include Rack::Test::Methods

  def app
    OngakuRyohoServer::Application
  end
end
