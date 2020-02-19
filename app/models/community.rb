class Community < ApplicationRecord
  belongs_to :region
  belongs_to :produce
end
