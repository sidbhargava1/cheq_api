class Api::V1::MenusController < ApplicationController
    respond_to :json
    
    def index 
    	respond_with Menu.all
  	end

    def show
        respond_with Menu.find(params[:id])
    end
end
