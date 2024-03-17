class CreateRestaurants < ActiveRecord::Migration[7.1]
  def change
    create_table :restaurants do |t|
      t.string :name
      t.string :location
      t.integer :will_split_votes, default: 0
      t.integer :wont_split_votes, default: 0

      t.timestamps
    end
  end
end
