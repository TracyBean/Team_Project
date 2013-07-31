class Eventbritefinder
    require 'json'
    require 'eventbrite-client'

    
    attr_accessor :data, :events
    
    def initialize search_terms
        @search_terms = search_terms
    end

    def fetch
        eb_auth_tokens = { app_key: ENV["EVENTBRITE_APP_KEY"] }
        eb_client = EventbriteClient.new(eb_auth_tokens)

        @data = []

        @search_terms.each do |search_term|
            begin
                response = eb_client.event_search({
                    keywords: @search_term,
                    city: "Boston",
                    region: "MA",
                    within: 15,
                    date: "This week"
                })
                unless (!defined? reponse || response["error"].present?)
                    @data << response
                end

            rescue RuntimeError
                next
            end
        end
    end
    
    def generate_events
        @events = []
        
        if @data.blank?
            return @events
        end

        @data.each do |response|
            response["events"].each do |item|
                if not item["event"].nil? then
                    eventfromitem = Event.find_or_create_by_name(
                        :name => item["event"]["title"],
                        :description => ActionController::Base.helpers.strip_tags(item["event"]["description"]),
                        :address => [item["event"]["venue"]["address"], item["event"]["venue"]["city"], item["event"]["venue"]["region"], item["event"]["venue"]["postal_code"]].reject(&:empty?).join(' '),
                        :event_time => item["event"]["start_date"],
                        :url => item["event"]["url"],
                        :source => "eventbrite"
                    ) do |e|
                        e.save!
                        @events.push(e)
                    end

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
