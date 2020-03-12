$(document).on('turbolinks:load', () => {
  $('.answer_select_action.selectable').each((index, elem) => {
    const answer_id = elem.attributes['data-answer-id'].value
    const url = location.pathname + '/select_answer'

    $(elem).on('click', () => {
      $.ajax({
        url,
        data: { answer_id },
        method: 'POST',
        success: (data) => {
          $('.answer_select_action.selected').removeClass('selected')
          if (data.selected) {
            $(elem).addClass('selected')
          }
        }
      })
    })
  })

  $('.edit_answer').on('click', (e) => {
    const answer_id = e.currentTarget.attributes['data-answer-id'].value
    $(`.answer__editor[data-answer-id=${answer_id}]`).toggleClass('hidden')
  })

  $('#question_vote_up, #question_vote_down').on(
    'click',
    generateClickEventHandler(
      '#question_vote_up',
      '#question_score',
      '#question_vote_down',
      '/vote_up',
      '/vote_down',
      '/remove_vote'
    )
  )

  $('.answer_vote_action').each((index, elem) => {
    const answer_id = elem.attributes['data-answer-id'].value

    $(elem).on(
      'click',
      generateClickEventHandler(
        `#answer_${answer_id}_vote_up`,
        `#answer_${answer_id}_score`,
        `#answer_${answer_id}_vote_down`,
        `/answers/${answer_id}/vote_up`,
        `/answers/${answer_id}/vote_down`,
        `/answers/${answer_id}/remove_vote`
      )
    )
  })
})

const generateClickEventHandler = (elem_up, elem_score, elem_down, up_vote_path, down_vote_path, remove_vote_path) => {
  return (e) => {
    let url = location.pathname
    const current_action = e.currentTarget.attributes['data-vote'].value
    url +=
      current_action == 'up'
        ? up_vote_path
        : current_action =='down'
          ? down_vote_path
          : remove_vote_path

    $.ajax({
      url,
      method: 'POST',
      success: (data) => {
        // data.vote is the current vote on the server.
        // If the current vote is "up" or "down",
        // clicking again will remove that vote
        $(elem_up).attr('data-vote', data.vote == 'up' ? 'remove' : 'up')
        $(elem_score).text(data.score)
        $(elem_down).attr('data-vote', data.vote == 'down' ? 'remove' : 'down')
      }
    })
  }
}
