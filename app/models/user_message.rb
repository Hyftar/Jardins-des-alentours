class UserMessage < ApplicationRecord
  validates :content, presence: true, length: { maximum: 10_000 }
  belongs_to :source_user, class_name: "User"
  belongs_to :recipient_user, class_name: "User"

  protected
  def self.save_user_message(message, source_user, recipient_user)
    UserMessage.create(source_user: source_user, recipient_user: recipient_user, content: message)
  end

end
