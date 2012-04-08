require_relative "ongaku_ryoho_server/version"
require_relative "ongaku_ryoho_server/application"

module OngakuRyohoServer
  #
  # { Class methods }

  def self.run(options)
    OngakuRyohoServer::Application.run!(options)
  end
end
