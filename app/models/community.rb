class Community < ApplicationRecord
  belongs_to :region
  belongs_to :produce
  has_and_belongs_to_many :users
end
