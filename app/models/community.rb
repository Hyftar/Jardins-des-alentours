class Community < ApplicationRecord
  belongs_to :location
  belongs_to :variety

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
