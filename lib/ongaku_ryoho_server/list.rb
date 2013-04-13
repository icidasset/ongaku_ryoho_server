module OngakuRyohoServer
  #
  # { List }
  #
  # === Info
  #
  # Module for handling the lists,
  # tracks data saved in json files

  module List

    CONFIG_PATH = File.expand_path("~/.ongaku_ryoho/server")

    #
    # Get digest
    #
    # => Creates a digest from the path of the current directory
    #
    def self.get_digest
      require "digest/sha1"
      digested_path = Digest::SHA1.hexdigest(Dir.pwd)
    end


    #
    # Configuration file path
    #
    # => Build path to config file
    #
    def self.config_file_path
      "#{CONFIG_PATH}/#{self.get_digest}.json"
    end


    #
    # Get
    #
    # => Get the list for the current directory
    #
    def self.get
      if File.file?(self.config_file_path)
        file_contents = File.open(path, "r").read
        OngakuRyohoServer::Process.encode_string(file_contents, "")
      end
    end


    #
    # Save
    #
    # => Save the list for the current directory
    #
    def self.save
      path = self.config_file_path
      file_list = OngakuRyohoServer::Process.directory
      collection = OngakuRyohoServer::Process.files(file_list).to_json

      # make path
      FileUtils.mkpath(CONFIG_PATH)

      # make file
      File.open(path, "w") do |f|
        f.write collection
      end
    end

  end
end
