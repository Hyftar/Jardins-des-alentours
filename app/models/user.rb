class User < ApplicationRecord
  validates :first_name, presence: true, length: { minimum: 2 }
  validates :last_name, presence: true, length: { minimum: 2 }

  validates_with LanguageCodeValidator

  has_and_belongs_to_many :roles

  has_many :gardens

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :trackable
end
