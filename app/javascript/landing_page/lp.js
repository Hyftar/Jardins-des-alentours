jQuery(document).ready(
  function() {

    // MOISE STYLE SCROLLING EVENT

    let $w = $(window);
    let $d = $('#right-veggie');
    let $y = $('#left-veggie');

    let lastScrollTop = $w.scrollTop();

    let _x = 0;

    $(window).scroll(function(event) {
      let st = $w.scrollTop();

      _x = st;

      lastScrollTop = st;

      $d.css('right', -_x * 4.5);

      $y.css('left', -_x * 4.5);
    });

    // ---------------------------

    // MOBILE MENU TOGGLE

    function triggerIconClick(x) {
      if (x.matches) { // If media query matches
        document.getElementById('app_icon').addEventListener(
          'click', toggleMenu);
      } else {
        document.getElementById('app_icon').removeEventListener(
          'click', toggleMenu);
      }
    }

    function toggleMenu() {
      $('#mobile_menu').toggle();
    }


    var x = window.matchMedia("(max-width: 1080px)");
    triggerIconClick(x);
    x.addEventListener('change', () => {
      document.getElementById('mobile_menu').style.display = "none";
      triggerIconClick(x);
    })





  });


