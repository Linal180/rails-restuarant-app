class Restaurant < ApplicationRecord
  scope :search_by_name_or_location, ->(query) {
    where("name ILIKE :query OR location ILIKE :query", query: "%#{query}%")
  }
end
