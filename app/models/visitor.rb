class Visitor < ApplicationRecord
    validates :request_count, numericality: { greater_than_or_equal_to: 0 }
    validates :IP, presence: true
end
