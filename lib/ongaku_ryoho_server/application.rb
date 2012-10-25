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
    set :server, :puma

    FILE_FORMATS = %w{ mp3 mp4 ogg flac wav wma }

    # root
    get "/" do
      content_type :json

      OngakuRyohoServer::List.get
    end


    # availability
    get "/available?" do
      "As it happens, I am."
    end


    # compare filelists
    post "/check" do
      content_type :json

      collection = params[:file_list]
      OngakuRyohoServer::Process.check_files(collection).to_json
    end


    # music file
    get %r{.(#{FILE_FORMATS.join("|")})$}i do
      requested_item = URI.unescape(request.path_info[1..-1])
      File.exists?(requested_item) ? send_file(requested_item) : 404
    end


    # everything else
    get %r{.+} do
      403
    end

  end
end
