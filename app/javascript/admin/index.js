$(document).on('turbolinks:load', () => {
  $('#user_role_search_form').on('ajax:success', (e) => {
    const [ data, status, xhr ] = e.detail
    $('#user_role_results').html(data.body.innerHTML)
    setupEvents()
  })

  setupEvents()
})

function setupEvents() {
  $('.show-roles-btn').on('click', (e) => {
    const elem = $(e.currentTarget).next()
    const wasHidden = elem.hasClass('hidden')
    $('.roles-checkboxes').addClass('hidden')
    if (wasHidden) {
      elem.removeClass('hidden')
    }
  })

  $('.roles-checkboxes__role > input[type="checkbox"]').change((e) => {
    const checkbox = $(e.currentTarget)
    const role_id = checkbox.attr('data-role-id')
    const user_id = checkbox.attr('data-user-id')
    const status = checkbox.prop('checked')
    const url = window.location.pathname + '/set_role'
    $.ajax({
      url,
      data: {
        role_id,
        user_id,
        status,
        lang: new URL(window.location.href).searchParams.get('lang')
      },
      type: 'POST',
      success: (data) => {
        toastr.success(data.message, '', { closeButton: true, progressBar: true, positionClass: 'toast-bottom-right' })
      },
      error: (data) => {
        toastr.error(data.message, '', { closeButton: true, progressBar: true, positionClass: 'toast-bottom-right' })
      }
    })
  })

  $('.roles-checkboxes__role > label').on('click', (e) => {
    const checkbox = $(e.currentTarget).siblings('input')

    if (checkbox.prop('disabled'))
      return

    const checked = checkbox.prop('checked')
    checkbox.prop('checked', !checked)
    checkbox.trigger('change')
  })
}
