$(document).on('turbolinks:load', () => {
  $('#question_vote_up').on('click', () => {
    $.ajax({
      url: window.location.href + '/vote_up',
      method: 'POST',
      success: (data) => {
        $('#question_score').text(data.score_value)
      }
    })
  })

  $('#question_vote_down').on('click', () => {
    $.ajax({
      url: window.location.href + '/vote_down',
      method: 'POST',
      success: (data) => {
        $('#question_score').text(data.score_value)
      }
    })
  })
})
