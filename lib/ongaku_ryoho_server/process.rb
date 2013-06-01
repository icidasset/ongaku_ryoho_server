require "taglib"
require "oj"

module OngakuRyohoServer
  #
  # { Process }
  #
  # === Info
  #
  # Module for processing the current directory
  # and music files

  module Process

    #
    # Read directory
    #
    # => find music in the current directory
    #
    # [output]
    #   file list
    #
    def self.directory
      file_formats = OngakuRyohoServer::Application::FILE_FORMATS.join(",")
      Dir.glob("**/*.{#{file_formats}}")
    end


    #
    # Check files
    #
    # => compares a given file list to the file list from the current directory
    #    show which files are missing and scan the ones that are new
    #
    # [params]
    #   file_list
    #
    # [output]
    #   object containing missing_files and new_tracks array
    #
    def self.check_files(file_list)
      file_list = begin JSON.parse(file_list) rescue [] end
      file_list_from_current_directory = JSON.parse(OngakuRyohoServer::List.get)
      file_list_from_current_directory.map! { |obj| obj["location"] }

      missing_files = file_list - file_list_from_current_directory
      new_files = file_list_from_current_directory - file_list

      new_tracks = OngakuRyohoServer::Process.files(
        new_files, { :last_modified => Time.now }
      )

      return {
        :missing_files => missing_files,
        :new_tracks => new_tracks
      }
    end


    #
    # Process files
    #
    # => open each music track, get its tags and return all of them
    #
    # [params]
    #   file_list : array of files (paths) to process
    #   extra_properties : properties to include in each track object/hash
    #
    # [output]
    #   tracks list : collection of all the tracks their tags
    #                 and the extra information
    #
    def self.files(file_list, extra_properties = {})
      tracks = []

      # loop over every track
      file_list.each do |location|
        rpartition = location.rpartition("/")
        filename = rpartition[2]

        next unless File.exist?(location)

        track = {}

        TagLib::FileRef.open(location) do |fileref|
          tag = fileref.tag

          tags = {
            :title => tag.title,
            :artist => tag.artist,
            :album => tag.album,
            :year => tag.year,
            :track => tag.track,
            :genre => tag.genre
          }

          tags.each do |key, value|
            tags[key] = "Unknown" if value.nil? or (value.respond_to?(:empty) and value.empty?)
          end

          tags.merge!({ :filename => filename, :location => location })

          tags.each do |k, v|
            tags[k] = OngakuRyohoServer::Process.encode_string(v) if v.is_a? String
          end

          track = tags.clone
        end

        unless track.empty?
          track.merge!(extra_properties)
          tracks << track
        end
      end

      # return all tracks
      return tracks
    end


    #
    # Helpers
    #
    def self.encode_string(string, replace_value="?")
      return string unless string.respond_to?(:force_encoding)
      new_string = string.force_encoding("cp1252")
      new_string.encode("UTF-8", { :invalid => :replace, :undef => :replace, :replace => replace_value })
    end

  end
end
