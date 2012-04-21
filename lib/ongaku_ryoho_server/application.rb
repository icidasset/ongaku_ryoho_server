require 'json'
require 'mp3info'
require 'sinatra'
require 'puma'
require 'uri'

module OngakuRyohoServer
  #
  # { Application }
  #
  # === Info
  #
  # Sinatra application which basicly takes care of everything
  # More info inside

  class Application < Sinatra::Base
    set :environment, :production
    set :server, :puma


    # root
    get '/' do
      content_type :json
      process_this_directory.to_json
    end


    # availability
    get '/available?' do
      "As it happens, I am."
    end


    # compare filelists
    post '/check' do
      content_type :json
      check_files(params[:file_list]).to_json
    end


    # music file
    get %r{.(mp3)$}i do
      requested_item = URI.unescape(request.path_info[1..-1])
      File.exists?(requested_item) ? send_file(requested_item) : 404
    end


    # crossdomain.xml
    get '/crossdomain.xml' do
      content_type :xml
      %{<?xml version="1.0"?>
        <!DOCTYPE cross-domain-policy SYSTEM "http://www.adobe.com/xml/dtds/cross-domain-policy.dtd">
        <cross-domain-policy>
           <allow-access-from domain="*" />
        </cross-domain-policy>
      }
    end


    # everything else
    get %r{.+} do
      403
    end


    #
    # Read directory
    #
    # => find music in the current directory
    #
    # [output]
    #   file list
    #
    def read_directory
      Dir.glob('**/*.{mp3}')
    end


    #
    # Check files
    #
    # => compares a given file list to the file list from the current directory
    #    show which files are missing and scan the ones that are new
    #
    # [params]
    #   file_list_from_client
    #
    # [output]
    #   object containing missing_files and new_tracks array
    #
    def check_files(file_list_from_client)
      file_list_from_client = JSON.parse(file_list_from_client)
      file_list_from_server = read_directory

      missing_files = file_list_from_client - file_list_from_server
      new_files = file_list_from_server - file_list_from_client

      new_tracks = process_music(new_files, { last_modified: Time.now })

      return {
        missing_files: missing_files,
        new_tracks: new_tracks
      }
    end


    #
    # Process this directory
    #
    # => read directory and process its contents
    #
    # [output]
    #   processed contents (see method below)
    #
    def process_this_directory
      music_collection = read_directory
      return process_music(music_collection)
    end


    #
    # Process music
    #
    # => open each music track, get its tags and return all of them
    #
    # [params]
    #   music_collection : array of files to process (i.e. filepaths)
    #   extra_properties : properties to include in each track object/hash
    #
    # [output]
    #   tracks : collection of all the tracks their tags
    #
    def process_music(music_collection, extra_properties = {})
      tracks = []

      # loop over every track
      music_collection.each do |location|
        rpartition = location.rpartition('/')
        filename   = rpartition[2]

        track = {}

        case File.extname(filename)
        when '.mp3'
          Mp3Info.open(location) do |mp3|
            tags = {
              title:    mp3.tag.title,
              artist:   mp3.tag.artist,
              album:    mp3.tag.album,
              year:     mp3.tag.year,
              tracknr:  mp3.tag.tracknum,
              genres:   mp3.tag.genre_s
            }

            tags.each do |key, value|
              tags[key] = 'Unknown' if value.nil? or (value.respond_to?(:empty) and value.empty?)
            end

            tags.merge!({ filename: filename, location: location })

            track = tags.clone
          end
        end

        unless track.empty?
          track.merge!(extra_properties)
          tracks << track
        end
      end

      # return all tracks
      return tracks
    end

  end
end