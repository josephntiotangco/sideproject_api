class Api::V2::AppCountersController < ApplicationController
    before_action :set_app_counter, except: [:index]
    FILTER_FIELD = ['id', 'name']
    
    def get_app_counter
        @app_counter = AppCounter.where("name=#{params[:name]}").first rescue nil
    end
end