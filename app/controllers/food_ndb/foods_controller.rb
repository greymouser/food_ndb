require_dependency "food_ndb/application_controller"

module FoodNdb
  class FoodsController < ApplicationController
    # GET /foods
    # GET /foods.json
    def index
      @foods = Food.all.paginate(:page => params[:page])

      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @foods }
      end
    end

    # GET /foods/1
    # GET /foods/1.json
    def show
      @food = Food.find(params[:id]).decorate

      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @food }
      end
    end
  end
end
