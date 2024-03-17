# app/controllers/restaurants_controller.rb
class RestaurantsController < ApplicationController
  before_action :set_restaurant, only: [:show, :edit, :update, :like, :dislike]

  def index
    if params[:search].present?
      @restaurants = Restaurant.search_by_name_or_location(params[:search])
    else
      @restaurants = Restaurant.all
    end

    respond_to do |format|
      format.html
      format.turbo_stream { render turbo_stream: turbo_stream.replace('restaurant_list', partial: 'restaurants/list', locals: { restaurants: @restaurants }) }
    end
  end

  def show
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    if @restaurant.save
      redirect_to @restaurant, notice: 'Restaurant was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @restaurant.update(restaurant_params)
      redirect_to @restaurant, notice: 'Restaurant was successfully updated.'
    else
      render :edit
    end
  end

  def like
    update_likes
  end

  def dislike
    update_dislikes
  end

  private

  def restaurant_params
    params.require(:restaurant).permit(:name, :location, :will_split_votes, :wont_split_votes)
  end

  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
  end

  def update_likes
    @restaurant.increment!(:will_split_votes)
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace("will-split-votes-#{@restaurant.id}", partial: "restaurants/vote_count", locals: { restaurant: @restaurant, like: true })
      end
    end
  end

  def update_dislikes
    @restaurant.increment!(:wont_split_votes)
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace("wont-split-votes-#{@restaurant.id}", partial: "restaurants/vote_count", locals: { restaurant: @restaurant, like: false })
      end
    end
  end
end
