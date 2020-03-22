$(document).on('turbolinks:load', () => {

  function findMeDistance() {
    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(success, failure);
    } else {
      toastr.error(geo_not_supported_garden, '', { closeButton: true, progressBar: true, positionClass: 'toast-bottom-right' })
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
          garden_markers.clearLayers()
          gardens_page_map.setView([latitude,longitude], 12)
          const gardens = data.garden
          if (gardens.length > 0){
            gardens.forEach(obj =>{
              const marker = L.marker([obj.latitude, obj.longitude]).addTo(garden_markers);

              const contener = document.createElement("div")

              const title = document.createElement("h5")
              title.innerHTML = obj.name
              contener.appendChild(title)

              const p = document.createElement("p")
              p.innerHTML = obj.description
              contener.appendChild(p)

              const link = document.createElement("a")
              link.innerHTML = visit_garden_garden
              link.href = data.url + obj.garden_id
              link.setAttribute('target', '_blank');
              contener.appendChild(link)

              marker.bindPopup(contener)
           })
            gardens_page_map.addLayer(garden_markers)
          }
          else {
            toastr.warning(data.message, '', { closeButton: true, progressBar: true, positionClass: 'toast-bottom-right' })
          }
        }
      })
    }
    function failure() {
      toastr.warning(error_location_garden, '', { closeButton: true, progressBar: true, positionClass: 'toast-bottom-right' })
    }
  }

  const locate_garden = document.querySelector('#locate-me-gardens')
  if (locate_garden !== null){
    locate_garden.addEventListener('click', findMeDistance)
  }

  const search_button_garden = document.querySelector("#search-button-gardens")
  if (search_button_garden !== null){
    search_button_garden.addEventListener("click", findAddressDistance)
  }

  function findAddressDistance(){
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
            gardens_page_map.setView([data.latitude,data.longitude], 12)
            garden_markers.clearLayers()
            if (gardens.length > 0){
              gardens.forEach(obj =>{
                const marker = L.marker([obj.latitude, obj.longitude]).addTo(garden_markers);
                const contener = document.createElement("div")

                const title = document.createElement("h5")
                title.innerHTML = obj.name
                contener.appendChild(title)

                const p = document.createElement("p")
                p.innerHTML = obj.description
                contener.appendChild(p)

                const link = document.createElement("a")
                link.innerHTML = visit_garden_garden
                link.href = data.url + obj.garden_id
                link.setAttribute('target', '_blank');
                contener.appendChild(link)

                marker.bindPopup(contener)
              })
              gardens_page_map.addLayer(garden_markers)
            }
            else {
              toastr.warning(data.message, '', { closeButton: true, progressBar: true, positionClass: 'toast-bottom-right' })
            }
          }
        }
      })
    }
  }

  let garden_markers = new L.FeatureGroup();
  let gardens_page_map
  if (document.getElementById('map_garden')){
    gardens_page_map = L.map('map_garden').setView([45.485, -73.59], 12);
    L.tileLayer('https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}', {
      attribution: 'Map data &copy; <a href="https://www.openstreetmap.org/">OpenStreetMap</a> contributors, <a href="https://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="https://www.mapbox.com/">Mapbox</a>',
      maxZoom: 18,
      id: 'mapbox/streets-v11',
      tileSize: 512,
      zoomOffset: -1,
      accessToken: 'pk.eyJ1Ijoia2V2ZW44MSIsImEiOiJjazdyNDQ3YXQwYTZzM2twNHJ2M2kxdXFtIn0.Vl_ZHudjkrDMIstvKBn53w'
    }).addTo(gardens_page_map);
  }

})
