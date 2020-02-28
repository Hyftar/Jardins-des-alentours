$(document).on('turbolinks:load', () => {
  $('#question_vote_up').on('click', (e) => {
    let url = window.location.href
    url += e.currentTarget.attributes['data-vote'].value == 'up' ? '/vote_up' : '/remove_vote'

    $.ajax({
      url,
      method: 'POST',
      success: (data) => {
        // If the current vote is "up", clicking again will remove that vote
        $('#question_vote_up').attr('data-vote', data.vote == 'up' ? 'remove' : 'up')
        $('#question_score').text(data.score)
        $('#question_vote_down').attr('data-vote', 'down')
      }
    })
  })

  $('#question_vote_down').on('click', (e) => {
    let url = window.location.href
    url += e.currentTarget.attributes['data-vote'].value == 'down' ? '/vote_down' : '/remove_vote'

    $.ajax({
      url,
      method: 'POST',
      success: (data) => {
        $('#question_vote_up').attr('data-vote', 'up')
        $('#question_score').text(data.score)
        // If the current vote is "down", clicking again will remove that vote
        $('#question_vote_down').attr('data-vote', data.vote == 'down' ? 'remove' : 'down')
      }
    })
  })
})
