class Yelpfinder

include Yelp::V2::Search::Request


    attr_accessor :data
    
    def initialize search_term
        @search_term = search_term
    end

    def fetch
        @client = Yelp::Client.new

        request = Location.new(
        :term => @search_term,
        :city => "Boston",
        :consumer_key => ENV["YELP_CONSUMER_KEY"],
        :consumer_secret => ENV["YELP_CONSUMER_SECRET"],
        :token => ENV["YELP_TOKEN"],
        :token_secret => ENV["YELP_TOKEN_SECRET"])

        response = @client.search(request)
        @data = response
    end

end
