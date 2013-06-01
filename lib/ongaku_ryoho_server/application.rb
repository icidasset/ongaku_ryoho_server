require "sinatra/base"

module OngakuRyohoServer
  #
  # { Application }
  #
  # === Info
  #
  # Sinatra application to handle the incoming
  # http requests or whatever

  class Application < Sinatra::Base
    set :environment, :production

    FILE_FORMATS = %w{ mp3 mp4 m4a ogg flac wav wma }

    # root
    get "/" do
      callback = params[:callback]
      json = OngakuRyohoServer::List.get

      if callback and !callback.empty?
        content_type :js
        response = "#{callback}(#{json})"
      else
        content_type :json
        response = json
      end

      response
    end


    # compare filelists
    post "/check" do
      collection = params[:file_list]
      callback = params[:callback]
      json = Oj.dump(OngakuRyohoServer::Process.check_files(collection))

      if callback and !callback.empty?
        content_type :js
        response = "#{callback}(#{json})"
      else
        content_type :json
        response = json
      end

      response
    end


    # music file
    get %r{.(#{FILE_FORMATS.join("|")})$}i do
      require "uri"
      requested_item = URI.unescape(request.path_info[1..-1])
      File.exists?(requested_item) ? send_file(requested_item) : 404
    end


    # everything else
    get %r{.+} do
      403
    end

  end
end
