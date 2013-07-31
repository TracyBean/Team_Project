class Yelpfinder
    require 'json'
    include Yelp::V2::Search::Request


    attr_accessor :data, :events
    
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
    
    def generate_events
        @events = []
        @data["businesses"].each do |item|
            eventfromitem = Event.find_or_create_by_name(
                :name => item["name"],
                :description => item["snippet_text"],
                :address => [item["location"]["address"], item["location"]["city"], item["location"]["state_code"], item["location"]["postal_code"]].reject(&:empty?).join(' '),
                :event_time => Time.now,
                :url => item["url"],
                :source => "yelp"
            )
            eventfromitem.save!
            @events.push(eventfromitem)
        end
        return @events
    end

    def fetch_and_generate_events
        self.fetch
        #debugger
        self.generate_events
    end

end
