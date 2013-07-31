class Meetupfinder
    require 'json'
    require 'meetup_client'

    
    attr_accessor :data, :events
    
    def initialize search_term
        @search_term = search_term
        @meetup_api = MeetupApi.new
    end

    def fetch
        params = { search: @search_term, order: 'trending', zip: '02139', desc: 'true', format: 'json', page: '20'}
        @data = @meetup_api.open_events(params)
        #debugger
        
    end
    
    def generate_events
        @events = []
        @data["results"].each do |item|
            if not item["id"].nil? then
                eventfromitem = Event.find_or_create_by_name(
                    :name => item["name"],
                    :description => item["description"],
                    :event_time => Time.at((item["time"]+item["utc_offset"])/1000),
                    :url => item["event_url"],
                    :source => "meetup"
                )
                unless item["venue"].nil?
                    eventfromitem.update_attributes(:address => [item["venue"]["address_1"].to_s, item["venue"]["city"].to_s, item["venue"]["state"].to_s, item["venue"]["zip"].to_s].reject(&:empty?).join(' '))
                end

                if item["venue"].nil? and not item["group"]["group_lat"].nil? then
                    eventfromitem.update_attributes(:latitude => item["group"]["group_lat"])
                    eventfromitem.update_attributes(:longitude => item["group"]["group_lon"])
                end

                eventfromitem.save!
                @events.push(eventfromitem)
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
