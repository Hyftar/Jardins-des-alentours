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
  // Permet de lancer la recherche dans la barre de recherche,
  // au clic de la touche entrer
  $('#search-address').keypress(function(e){
    if(e.keyCode==13)
    $('#search-button').click();
  });

  // MOBILE MENU TOGGLE
  function triggerIconClick(mediaQuery) {
    const navbar = document.getElementById('navbar')
    if (mediaQuery.matches) {
      navbar.addEventListener('click', toggleMenu)
    } else {
      navbar.removeEventListener('click', toggleMenu)
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

  function findMe() {
    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(success, failure);
    } else {
      toastr.error(geo_not_supported, '', { closeButton: true, progressBar: true, positionClass: 'toast-bottom-right' })
    }

    function success(position) {
      const latitude  = position.coords.latitude;
      const longitude = position.coords.longitude;
      const distance = document.getElementById("distance").value
      const markets = document.getElementById("markets").checked
      $.ajax({
        url: "/geolocalise",
        dataType: "json",
        data: { latitude: latitude, longitude: longitude, distance: distance, markets: markets },
        method: 'GET',
        success: (data) => {
          landing_page_map.setView([latitude,longitude], 12)
          const gardens = data.garden
          landing_markers.clearLayers()
          if (gardens.length > 0){
            gardens.forEach(obj =>{
              const marker = L.marker([obj.latitude, obj.longitude]).addTo(landing_markers);

              const contener = document.createElement("div")

              const title = document.createElement("h5")
              title.innerHTML = obj.name
              contener.appendChild(title)

              const p = document.createElement("p")
              p.innerHTML = obj.description
              contener.appendChild(p)

              const link = document.createElement("a")
              link.innerHTML = visit_garden
              link.href = data.url + obj.garden_id
              link.setAttribute('target', '_blank');
              contener.appendChild(link)

              marker.bindPopup(contener)
            })
            landing_page_map.addLayer(landing_markers)
          }
          else {
            toastr.warning(data.message, '', { closeButton: true, progressBar: true, positionClass: 'toast-bottom-right' })
          }
        }
      })
    }

    function failure() {
      toastr.warning(error_location, '', { closeButton: true, progressBar: true, positionClass: 'toast-bottom-right' })
    }
  }

  let landing_page_map

  if (document.getElementById('mapid')){
    landing_page_map = L.map('mapid').setView([45.485, -73.59], 12);
    L.tileLayer('https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}', {
      attribution: 'Map data &copy; <a href="https://www.openstreetmap.org/">OpenStreetMap</a> contributors, <a href="https://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="https://www.mapbox.com/">Mapbox</a>',
      maxZoom: 18,
      id: 'mapbox/streets-v11',
      tileSize: 512,
      zoomOffset: -1,
      accessToken: 'pk.eyJ1Ijoia2V2ZW44MSIsImEiOiJjazdyNDQ3YXQwYTZzM2twNHJ2M2kxdXFtIn0.Vl_ZHudjkrDMIstvKBn53w'
    }).addTo(landing_page_map);
  }

  let landing_markers = new L.FeatureGroup();

  const locate = document.querySelector('#locate-me')
  if (locate !== null){
    locate.addEventListener('click', findMe)
  }

  const search_button = document.querySelector("#search-button")
  if (search_button !== null){
    search_button.addEventListener("click", findAddress)
  }

  function findAddress(){
    const address = document.getElementById("search-address").value
    const distance = document.getElementById("distance").value
    const markets = document.getElementById("markets").checked
    if (address != ""){
      $.ajax({
        url: "/geolocalise_address",
        dataType: "json",
        data: { address: address, distance: distance, markets: markets },
        method: 'GET',
        success: (data) => {
          const gardens = data.garden
          if (gardens == undefined || gardens == null){
            toastr.warning(data.message, '', { closeButton: true, progressBar: true, positionClass: 'toast-bottom-right' })
          }
          else {
            landing_page_map.setView([data.latitude,data.longitude], 12)
            landing_markers.clearLayers()
            if (gardens.length > 0){
              gardens.forEach(obj =>{
                const marker = L.marker([obj.latitude, obj.longitude]).addTo(landing_markers);
                const contener = document.createElement("div")

                const title = document.createElement("h5")
                title.innerHTML = obj.name
                contener.appendChild(title)

                const p = document.createElement("p")
                p.innerHTML = obj.description
                contener.appendChild(p)

                const link = document.createElement("a")
                link.innerHTML = visit_garden
                link.href = data.url + obj.garden_id
                link.setAttribute('target', '_blank');
                contener.appendChild(link)

                marker.bindPopup(contener)
              })
              landing_page_map.addLayer(landing_markers)
            }
            else {
              toastr.warning(data.message, '', { closeButton: true, progressBar: true, positionClass: 'toast-bottom-right' })
            }
          }
        }
      })
    }
  }
  $('#blinking').click(() => {
    $('html, body').animate({
      scrollTop: $('#first-slide').offset().top
    }, 'slow')
  })

})
