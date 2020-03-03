$(document).on('turbolinks:load', () => {
  // MOSES STYLE SCROLLING EVENT
  const $w = $(window);
  const $d = $('#right-veggie');
  const $y = $('#left-veggie');

  $(window).scroll((event) => {
    const st = $w.scrollTop();
    $d.css('right', -st * 1.5);
    $y.css('left', -st * 1.5);
  })

  // MOBILE MENU TOGGLE
  function triggerIconClick(mediaQuery) {
    const icon = document.getElementById('app_icon')
    if (mediaQuery.matches) {
      icon.addEventListener('click', toggleMenu)
    } else {
      icon.removeEventListener('click', toggleMenu)
    }
  }

  function toggleMenu() {
    $('#mobile_menu').toggle();
  }

  const mediaQuery = window.matchMedia("(max-width: 1080px)")
  triggerIconClick(mediaQuery)
  mediaQuery.addEventListener('change', () => {
    document.getElementById('mobile_menu').style.display = "none"
    triggerIconClick(mediaQuery)
  })
})
