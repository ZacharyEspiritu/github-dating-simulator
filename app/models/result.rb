class Result < ApplicationRecord
    serialize :data, Array
    serialize :percentages, Array

    def self.random_room_code
        [Faker::Color.color_name, Faker::Hacker.noun, rand(100)].join("-").split.join.downcase
      end

  # Allows us to set a custom URL slug.
  def to_param
    result_name
  end
end
