class Variety < ApplicationRecord
  has_one_attached :image
  has_many :communities
  has_many :garden_varieties
  has_many :gardens, through: :garden_varieties
  belongs_to :origin, class_name: "Location", optional: true
  belongs_to :parent, class_name: "Variety", optional: true

  enum sun_exposure: %i( shadow half_exposed fully_exposed )
  flag :planting_method, %i( direct_seeding sowing poting )

  validates(:name,
    presence: true,
    length: { minimum: 2, maximum: 120 },
    uniqueness: true
  )

  validate :parent_must_not_be_self
  validates :image, blob: { content_type: :image, size_range: 1..100.megabytes}
  validates :description, length: { maximum: 10_000 }, presence: true

  def self.find_varieties_unused_in_garden(garden_id)
    query_string = <<-EOF
    SELECT * FROM varieties WHERE varieties.id
    NOT IN (SELECT v.id FROM varieties as v
    INNER JOIN garden_varieties ON garden_varieties.variety_id = varieties.id
    WHERE garden_varieties.garden_id = ?)
    EOF
    @varieties = Variety.find_by_sql [query_string, garden_id]
  end

  private
    def parent_must_not_be_self
      if parent == self
        errors.add(
          :parent,
          I18n.t("varieties.parent_must_not_be_self")
        )
      end
    end
end
