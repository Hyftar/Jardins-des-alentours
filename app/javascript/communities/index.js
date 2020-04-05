$(document).on('turbolinks:load', () => {
  $('#slider').on('input', selectSeason)
  selectSeason()
})

// select season from value of slider

function selectSeason() {
  const e = $('#slider')
  e.attr('value', e.val())
  let season = ''

  switch (e.val()) {
    case '1':
      season = 'Été'
      chooseSeason('summer')
      break
    case '2':
      season = 'Automne'
      chooseSeason('fall')
      break
    case '3':
      season = 'Hiver'
      chooseSeason('winter')
      break
    case '4':
      season = 'Printemps'
      chooseSeason('spring')
      break
    default:
      season = 'Toutes les saisons' // TODO: I18n this string
      const items = $('.filter-item')
      items.each((index, elem) => {
        elem.classList.remove('not-in-season')
      })
      break
  }
  e.attr('data-tooltip', season)
}

// for each filtered item we add or remove them from display if they are in season or not

function chooseSeason(season) {
  let items = $('.filter-item')
  items.each((index, elem) => {
    if (elem.attributes['data-season'].value.indexOf(season) !== -1) {
      elem.classList.remove('not-in-season')
    } else {
      elem.classList.add('not-in-season')
    }
  })
}
