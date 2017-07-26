class UserData < ApplicationRecord
  serialize :data, Hash
end
