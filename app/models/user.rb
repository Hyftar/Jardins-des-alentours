class User < ApplicationRecord
  validates :first_name, presence: true, length: { minimum: 2 }
  validates :last_name, presence: true, length: { minimum: 2 }

  validates :language, language_code: true

  has_and_belongs_to_many :roles
  has_many :user_messages
  has_many :gardens

  has_and_belongs_to_many :communities

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :trackable
end
