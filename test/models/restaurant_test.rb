
require 'test_helper'

class RestaurantTest < ActiveSupport::TestCase
  test "search_by_name_or_location should return restaurants matching name or location" do
    restaurant1 = Restaurant.create(name: "Restaurant A", location: "Location A")
    restaurant2 = Restaurant.create(name: "Restaurant B", location: "Location B")
    restaurant3 = Restaurant.create(name: "Restaurant C", location: "Location C")

    # Test with a query that matches one restaurant's name
    results = Restaurant.search_by_name_or_location("Restaurant A")
    assert_includes results, restaurant1
    assert_not_includes results, restaurant2
    assert_not_includes results, restaurant3

    # Test with a query that matches one restaurant's location
    results = Restaurant.search_by_name_or_location("Location B")
    assert_not_includes results, restaurant1
    assert_includes results, restaurant2
    assert_not_includes results, restaurant3

    # Test with a query that matches both name and location of one restaurant
    results = Restaurant.search_by_name_or_location("Restaurant C")
    assert_not_includes results, restaurant1
    assert_not_includes results, restaurant2
    assert_includes results, restaurant3

    # Test with a query that doesn't match any restaurant
    results = Restaurant.search_by_name_or_location("Nonexistent")
    assert_empty results
  end
end
