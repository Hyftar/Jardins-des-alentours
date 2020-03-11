class Community < ApplicationRecord
  belongs_to :region
  belongs_to :produce
  has_and_belongs_to_many :users

  after_create :create_community_roles

  def create_community_roles
    Role.create!([
      { name: "moderator", community: self },
      { name: "admin", community: self }
    ])
  end
end
