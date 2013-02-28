class TestController < ApplicationController
  def index
    @food = FoodNdb::Food.find(params[:id]).decorate

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @food }
    end
  end
end
