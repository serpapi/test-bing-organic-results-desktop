describe "SerpApi Desktop JSON" do

  describe "Organic Results for apple.com" do

    before :all do
      @response = HTTP.get 'https://serpapi.com/search.json?q=apple.com&source=test&engine=bing'
      @json = @response.parse
    end

    it "returns http success" do
      expect(@response.code).to be(200)
    end

    it "contains organic results array" do
      expect(@json["organic_results"]).to be_an(Array)
    end

    describe "have first result" do

      before :all do
        @result = @json["organic_results"][0]
      end

      it "is first" do
        expect(@result["position"]).to be(1)
      end

      it "apple.com title" do
        expect(@result["title"]).to eql("Apple")
      end

      it "apple.com links" do
        expect(@result["link"]).to eql("https://www.apple.com/")
        expect(@result["displayed_link"]).to eql("https://www.apple.com")
      end

      it "has a snippet" do
        expect(@result["snippet"]).to_not be_empty
      end

      it "has expanded sitelinks" do
        expect(@result["sitelinks"]).to be_a(Hash)
        expect(@result["sitelinks"]["expanded"]).to be_a(Array)
        expect(@result["sitelinks"]["expanded"][0]["title"]).to_not be_empty
        expect(@result["sitelinks"]["expanded"][0]["link"]).to_not be_empty
      end

    end

  end

end
