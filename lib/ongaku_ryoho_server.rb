require "json"
require "uri"
require "digest/sha1"
require "puma"
require "sinatra"
require "taglib"

require_relative "ongaku_ryoho_server/version"
require_relative "ongaku_ryoho_server/process"
require_relative "ongaku_ryoho_server/list"
require_relative "ongaku_ryoho_server/application"

module OngakuRyohoServer
  def self.run(options)
    OngakuRyohoServer::Application.run!(options)
  end
end
