class Meetupfinder
    require 'json'
    require 'meetup_client'

    
    attr_accessor :data, :events
    
    def initialize search_term
        @search_term = search_term
        @meetup_api = MeetupApi.new
    end

    def fetch
        topicparams = { search: @search_term, order: 'members', format: 'json', page: '20'}
        debugger
        @topics = @meetup_api.topics(topicparams)
        @data = []
        @biggertopics = []
        @topics.each do |topic|
            if topic["members"] > 250
                @biggertopics << topic
            end
        end

        @biggertopics.each do |topic|
           @data << RMeetup::Client.fetch(:events,{
           :topic => topic.urlkey,
           :zip => '02139',
           :order => 'trending',
           :desc => 'true'})
        end
        debugger
    end
    
    def generate_events
        @events = []
        @data["events"].each do |item|
            if not item["event"].nil? then
                eventfromitem = Event.find_or_create_by_name(
                    :name => item["event"]["title"],
                    :description => ActionController::Base.helpers.strip_tags(item["event"]["description"]),
                    :address => [item["event"]["venue"]["address"], item["event"]["venue"]["city"], item["event"]["venue"]["region"], item["event"]["venue"]["postal_code"]].reject(&:empty?).join(' '),
                    :time => item["event"]["start_date"],
                    :url => item["event"]["url"]
                )
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
