module ApplicationHelper
  # Updates the score of the specified instances of models
  # with a diff (difference between current score and wanted value)
  def self.update_score_of(instances, diff)
    # Lock all the instances to prevent other transactions modifying
    # the tables at the same time
    instances.each(&:lock!)
    instances.each { |instance| instance.score += diff }
    instances.each(&:save!)
  end
end
