class Variety < ApplicationRecord
  belongs_to :produce

  validates :name, presence: true, length: { minimum: 2, maximum: 120 }
  validates :produce, presence: true

  has_many :garden_varieties
  has_many :gardens, through: :garden_varieties

  private
    # Get varieties not presently in the garden
    def self.find_varieties_unused_in_garden(garden_id)
      query_string = <<-EOF
      SELECT * FROM varieties WHERE varieties.id
      NOT IN (SELECT v.id FROM varieties as v
      INNER JOIN garden_varieties ON garden_varieties.variety_id = varieties.id
      WHERE garden_varieties.garden_id = ?)
      EOF
      @varieties = Variety.find_by_sql [query_string, garden_id]
    end
end
