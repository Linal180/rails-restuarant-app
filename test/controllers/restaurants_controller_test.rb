# test/controllers/restaurants_controller_test.rb
require "test_helper"

class RestaurantsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @restaurant = Restaurant.create(name: 'test', location: 'test')
    @restaurant1 = Restaurant.create(name: 'test2', location: 'boston')
    @restaurant2 = Restaurant.create(name: 'test3', location: 'germany')
  end

  test "should get index and return all retaurants with no search parameter" do
    get restaurants_url
    assert_response :success
    assert_not_nil assigns(:restaurants)
    assert_includes assigns(:restaurants), @restaurant
    assert_includes assigns(:restaurants), @restaurant1
    assert_includes assigns(:restaurants), @restaurant2
  end

  test "should get index with search parameter" do
    get restaurants_url(search: 'boston')
    assert_response :success
    assert_not_nil assigns(:restaurants)
    assert_includes assigns(:restaurants), @restaurant1
  end

  test "should get show" do
    get restaurant_url(@restaurant)
    assert_response :success
  end

  test "should get new" do
    get new_restaurant_url
    assert_response :success
  end

  test "should create restaurant" do
    assert_difference('Restaurant.count') do
      post restaurants_url, params: { restaurant: { name: @restaurant.name, location: @restaurant.location } }
    end

    assert_redirected_to restaurant_url(Restaurant.last)
  end

  test "should get edit" do
    get edit_restaurant_url(@restaurant)
    assert_response :success
  end

  test "should update restaurant" do
    patch restaurant_url(@restaurant), params: { restaurant: { name: @restaurant.name, location: @restaurant.location } }
    assert_redirected_to restaurant_url(@restaurant)
  end

  test "should increment will_split_votes when liked" do
    assert_difference('@restaurant.reload.will_split_votes', 1) do
      post like_restaurant_url(@restaurant)
    end
  end

  test "should increment wont_split_votes when disliked" do
    assert_difference('@restaurant.reload.wont_split_votes', 1) do
      post dislike_restaurant_url(@restaurant)
    end
  end  
end
