class EventsController < ApplicationController
    require 'json'

    
  # GET /events
  # GET /events.json

  def index
      @yelp_search_terms = ["programming", "weird", "weirdo", "bookstore", "harvard", "jazz"]
      @eb_search_terms = ["programming%20OR%20startup%20OR%20mathematics"]
      @meetup_search_terms = ["indie+jazz+philosophy+physics"]
      @events = Yelpfinder.new(@yelp_search_terms).fetch_and_generate_events
      Eventbritefinder.new(@eb_search_terms).fetch_and_generate_events.each do |event|
          @events << event
      end
      Meetupfinder.new(@meetup_search_terms).fetch_and_generate_events.each do |event|
          @events << event
      end

      @events.sort! { |a,b| b.score <=> a.score }


    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @events }
    end
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @event = Event.find(params[:id])
    
    @json = @event.to_gmaps4rails

    @gmaps_options = {
        "map_options" => {
            "auto_zoom" => false,
            "zoom" => 15,
            "center_latitude" => @event.latitude,
            "center_longitude" => @event.longitude
    },
    "markers" => {
      "data" => @json
    }
    }

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @event }
    end
  end

  # GET /events/new
  # GET /events/new.json
  def new
    @event = Event.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @event }
    end
  end

  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(params[:event])

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render json: @event, status: :created, location: @event }
      else
        format.html { render action: "new" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /events/1
  # PUT /events/1.json
  def update
    @event = Event.find(params[:id])

    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    respond_to do |format|
      format.html { redirect_to events_url }
      format.json { head :no_content }
    end
  end
end
