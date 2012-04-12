require 'daemons'

require_relative "ongaku_ryoho_server/version"
require_relative "ongaku_ryoho_server/application"

module OngakuRyohoServer
  #
  # { Class methods }

  def self.run(options)
    Daemons.daemonize({ app_name: 'ongaku_ryoho_server', log_output: true, backtrace: true }) if options[:daemonize]
    OngakuRyohoServer::Application.run!(options[:sinatra])
  end
end
