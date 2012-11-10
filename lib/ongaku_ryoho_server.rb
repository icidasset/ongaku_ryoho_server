require "sinatra/base"
require "taglib"

require "json"
require "uri"
require "digest/sha1"

require_relative "ongaku_ryoho_server/version"
require_relative "ongaku_ryoho_server/process"
require_relative "ongaku_ryoho_server/list"
require_relative "ongaku_ryoho_server/application"

module OngakuRyohoServer; end
