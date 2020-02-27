class Question < ApplicationRecord
  validates :user, presence: true
  validates :community, presence: true

  # Opened means it has no answers
  # Pending means it has been answered, no answer was selected
  # Removed means it has been deleted by an admin
  # Deleted means it has been deleted by the user
  # Closed means it has a selected answer
  enum status: %i( opened pending removed deleted closed )

  validate :selected_answer_must_be_children_of_question

  has_and_belongs_to_many :tags
  has_and_belongs_to_many :varieties
  has_many :answers
  belongs_to :user
  belongs_to :community
  belongs_to :selected_answer, class_name: "Answer", optional: true

  private
    def selected_answer_must_be_children_of_question
      if selected_answer.present? && selected_answer.question != self
        errors.add(
          :selected_answer,
          I18n.t("selected_answer_not_children_of_question")
        )
      end
    end
end
