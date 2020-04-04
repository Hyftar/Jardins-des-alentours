class Community < ApplicationRecord
  belongs_to :location
  belongs_to :variety
  has_and_belongs_to_many :users

  after_create :create_community_roles

  accepts_nested_attributes_for :location

  def create_community_roles
    Role.create!(
      [
        { name: "moderator", community: self },
        { name: "admin", community: self }
      ]
    )
  end
end
