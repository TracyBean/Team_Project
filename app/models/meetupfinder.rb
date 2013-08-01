class Meetupfinder
    require 'json'
    require 'meetup_client'

    
    attr_accessor :data, :events
    
    def initialize search_terms
        @search_terms = search_terms
        @meetup_api = MeetupApi.new
    end

    def fetch
        @data = []
        @search_terms.each do |term|
            params = { text: term, order: 'trending', zip: '02139', desc: 'true', time: ',1m', format: 'json', page: '20', fields: "trending_rank"}
            @data << @meetup_api.open_events(params)
        end
    end
    
    def generate_events
        @events = []
        @data.each do |response|
            response["results"].each do |item|
                if not item["id"].nil? then
                    eventfromitem = Event.find_or_create_by_url_and_score(
                        :name => item["name"],
                        :description => item["description"],
                        :event_time => Time.at((item["time"]+item["utc_offset"])/1000),
                        :url => item["event_url"],
                        :source => "meetup",
                        :score => 15-(item["trending_rank"])/10 + item["yes_rsvp_count"]/10 + item["maybe_rsvp_count"]/15
                    ) do |e|

                        unless item["venue"].nil?
                            e.update_attributes(:address => [item["venue"]["address_1"].to_s, item["venue"]["city"].to_s, item["venue"]["state"].to_s, item["venue"]["zip"].to_s].reject(&:empty?).join(' '))
                        end

                        if item["venue"].nil? and not item["group"]["group_lat"].nil? then
                            e.update_attributes(:latitude => item["group"]["group_lat"])
                            e.update_attributes(:longitude => item["group"]["group_lon"])
                        end

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
