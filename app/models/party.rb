class Party < ApplicationRecord
  serialize :usernames, Array

  def self.random_room_code
    [Faker::Color.color_name, Faker::Hacker.noun, rand(100)].join("-").split.join.downcase
  end

  def self.random_edit_key
    ('a'..'z').to_a.shuffle[0,16].join
  end

  def to_param
    party_name
  end
end
