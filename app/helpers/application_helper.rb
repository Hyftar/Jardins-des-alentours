module ApplicationHelper
  def toastr_flash
    flash.each_with_object([]) do |(type, message), flash_messages|
      type = type == "notice" ? "success" : "error"
      text = "<script>toastr.#{type}('#{message}', '', { closeButton: true, progressBar: true, positionClass: 'toast-bottom-right' })</script>"
      flash_messages << text.html_safe if message
    end.join("\n").html_safe
  end

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
