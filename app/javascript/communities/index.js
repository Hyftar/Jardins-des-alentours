$(document).on('turbolinks:load', () => {
  $('#slider').on('input', selectSeason);
  selectSeason();
});

function selectSeason() {
  let e = $('#slider');
  e.attr('value', e.val());
  let season = '';

  switch (e.val()) {
    case '1':
      season = 'Été';
      chooseSeason('summer');
      break;
    case '2':
      season = 'Automne';
      chooseSeason('fall')
      break;
    case '3':
      season = 'Hiver';
      chooseSeason('winter')
      break;
    case '4':
      season = 'Printemps';
      chooseSeason('spring')
      break;
    default:
      season = 'Toutes les saisons';
      let items = $('.filter-item');
      items.each((x) => {
        items.eq(x).removeClass('not-in-season');
      });
      break;
  }
  e.attr('data-tooltip', season);
}

function chooseSeason(season) {
  let items = $('.filter-item');
  items.each((x) => {
    if (items.eq(x).attr('data-season').includes(season)) {
      items.eq(x).removeClass('not-in-season');
    } else {
      items.eq(x).addClass('not-in-season');
    }
  });
}
