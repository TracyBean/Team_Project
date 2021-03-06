class Yelpfinder
    require 'json'
    include Yelp::V2::Search::Request


    attr_accessor :data, :events
    
    def initialize search_terms
        @search_terms = search_terms
    end

    def fetch
        @data = []
        @client = Yelp::Client.new

        @search_terms.each do |term|
            request = Location.new(
                :term => term,
                :city => "Boston",
                :consumer_key => ENV["YELP_CONSUMER_KEY"],
                :consumer_secret => ENV["YELP_CONSUMER_SECRET"],
                :token => ENV["YELP_TOKEN"],
                :token_secret => ENV["YELP_TOKEN_SECRET"])
                
                response = @client.search(request)
                @data << response
        end
    end
    
    def generate_events
        @events = []
        @data.each do |response|
            response["businesses"].each do |item|
                eventfromitem = Event.find_or_create_by_url_and_score(
                    :name => item["name"],
                    :description => item["snippet_text"],
                    :address => [item["location"]["address"], item["location"]["city"], item["location"]["state_code"], item["location"]["postal_code"]].reject(&:empty?).join(' '),
                    :event_time => Time.now,
                    :url => item["url"],
                    :source => "yelp",
                    :score => (item["review_count"]*item["rating"])/120
                 ) do |e|
                    e.save!
                    @events.push(e)
                end
            end
        end
        return @events
    end

    def fetch_and_generate_events
        self.fetch
        #debugger
        self.generate_events
    end

end
