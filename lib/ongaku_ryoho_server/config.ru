options = OngakuRyohoServer::OPTIONS


#
# Build file list (only if needed or request)

config_file_path = OngakuRyohoServer::List.config_file_path
if !File.file?(config_file_path) or options[:update_collection]
  OngakuRyohoServer::List.save
  puts "Collection saved at #{config_file_path}\n\n"
end


#
# Run the application

run OngakuRyohoServer::Application.new(options[:thin])
