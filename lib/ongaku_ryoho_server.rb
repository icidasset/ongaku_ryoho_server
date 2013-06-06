require "rubygems"
require "taglib"
require "oj"
require "sinatra/base"
require "sinatra/cross_origin"

require "uri"
require "digest/sha1"

require "#{File.dirname(__FILE__)}/ongaku_ryoho_server/process"
require "#{File.dirname(__FILE__)}/ongaku_ryoho_server/list"
require "#{File.dirname(__FILE__)}/ongaku_ryoho_server/application"


module OngakuRyohoServer
end
