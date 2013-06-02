require File.expand_path("../spec_helper.rb", __FILE__)

describe "Application" do

  #
  #  Index (GET)
  #
  describe "GET /" do
    before do
      OngakuRyohoServer::List.save
    end

    it "should return json" do
      get "/"
      last_response.must_be :ok?
      last_response.content_type.must_equal "application/json;charset=utf-8"
    end

    it "should return jsonp" do
      get "/", :callback => "test"
      last_response.must_be :ok?
      last_response.content_type.must_equal "application/javascript;charset=utf-8"
    end

    it "should have 3 items" do
      get "/"
      json = Oj.load(last_response.body)
      json.length.must_equal 3
    end

    it "should have an item with the necessary keys" do
      get "/"

      json = Oj.load(last_response.body)
      first_item = json.first

      first_item.has_key?(:title).must_equal true
      first_item.has_key?(:artist).must_equal true
      first_item.has_key?(:album).must_equal true
      first_item.has_key?(:year).must_equal true
      first_item.has_key?(:track).must_equal true
      first_item.has_key?(:genre).must_equal true
    end
  end


  #
  #  Check (POST)
  #
  describe "POST /check" do
    before do
      OngakuRyohoServer::List.save
    end

    it "should have 2 parent keys" do
      post "/check"
      json = Oj.load(last_response.body)
      json[:missing_files].must_be_kind_of Array
      json[:new_tracks].must_be_kind_of Array
    end

    it "should have 3 new tracks when given empty file list" do
      post "/check", :file_list => Oj.dump([])
      json = Oj.load(last_response.body)
      json[:new_tracks].length.must_equal 3
    end

    it "should have 0 new tracks when given same file list" do
      file_list = [
        { :location => "spec/data/a.mp3" },
        { :location => "spec/data/b.mp3" },
        { :location => "spec/data/c.mp3" }
      ]

      post "/check", :file_list => Oj.dump(file_list)
      json = Oj.load(last_response.body)
      json[:new_tracks].length.must_equal 3
    end

    it "should have 3 missing files" do
      file_list = [
        { :location => "spec/data/a.mp3" },
        { :location => "spec/data/b.mp3" },
        { :location => "spec/data/c.mp3" }
      ]

      post "/check",
        :file_list => Oj.dump(file_list),
        :other_file_list => Oj.dump([])

      json = Oj.load(last_response.body)
      json[:missing_files].length.must_equal 3
    end
  end


  #
  #  Files (GET)
  #
  describe "GET /*.ALLOWED_FILE_FORMAT" do
    it "should be able to load a.mp3" do
      get "/spec/data/a.mp3"
      last_response.status.must_equal 200
      last_response.content_type.must_equal "audio/mpeg"
    end

    it "should return a 404 if the file doesn't exist" do
      get "/spec/data/does_not_exist.mp3"
      last_response.status.must_equal 404
    end
  end


  describe "GET /*.DISALLOWED_FILE_FORMAT" do
    it "should return a 403" do
      get "/forbidden.tar.gz"
      last_response.status.must_equal 403
    end
  end

end
