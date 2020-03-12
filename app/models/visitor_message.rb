class VisitorMessage < ApplicationRecord
  belongs_to :source_visitor_email, class_name: "VisitorEmail"
  belongs_to :recipient_user, class_name: "User"
  validates :content, presence: true, length: { maximum: 10_000 }

  protected
    def self.save_visitor_message(message, source_visitor, recipient_user)
      VisitorMessage.create(source_visitor_email: source_visitor, recipient_user: recipient_user, content: message)
    end
end
