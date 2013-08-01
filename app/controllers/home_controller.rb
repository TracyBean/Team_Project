class HomeController < ApplicationController
    before_filter :set_profile
    def set_profile
        @profile = Profile.first.blank? ? Profile.new : Profile.first
    end

    def index
    end

    def drinks
        @profile.music = params[:music]
        @profile.save!
    end

    def movies
        @profile.drink = params[:drink]
        @profile.save!
    end
    
    def tv
        @profile.movie = params[:movie]
        @profile.save!
    end
end
