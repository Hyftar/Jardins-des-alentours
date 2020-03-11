class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question, touch: true
  has_one :community, through: :question
  has_many :answer_votes

  has_rich_text :content

  validates_uniqueness_of(
    :user_id,
    scope: :question_id,
    conditions: -> { where.not(status: [:removed, :deleted]) }
  )

  # Active is the default status
  # Removed means it has been deleted by an admin
  # Deleted means it has been deleted by the user
  enum status: %i( active removed deleted )

  counter_culture :question, touch: true, column_name: proc { |answer| answer.active? ? "answers_count" : nil }

  def self.all_with_votes_from(user, question)
    self.find_by_sql(
      [
        '
          SELECT answers.*, answer_votes.vote
          FROM answers
          LEFT OUTER JOIN answer_votes
          ON answers.id = answer_votes.answer_id AND answer_votes.user_id = ?
          WHERE answers.question_id = ? AND status = 0
          ORDER BY answers.score DESC
        ',
        user&.id,
        question&.id
      ]
    )
  end
end
