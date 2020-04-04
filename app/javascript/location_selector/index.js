$(document).on('turbolinks:load', () => {
  setupLocationSelector()
})

function setupLocationSelector() {
  let selector_map = null
  let marker = null
  if (document.getElementById('map_location_selector') == null) {
    return
  }

  selector_map = L.map('map_location_selector').setView([45.485, -73.59], 12)

  L.tileLayer(
    'https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}',
    {
      attribution: 'Map data &copy <a href="https://www.openstreetmap.org/">OpenStreetMap</a> contributors, <a href="https://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="https://www.mapbox.com/">Mapbox</a>',
      maxZoom: 18,
      id: 'mapbox/streets-v11',
      tileSize: 512,
      zoomOffset: -1,
      accessToken: 'pk.eyJ1Ijoia2V2ZW44MSIsImEiOiJjazdyNDQ3YXQwYTZzM2twNHJ2M2kxdXFtIn0.Vl_ZHudjkrDMIstvKBn53w'
    }
  ).addTo(selector_map)

  selector_map.on('click', (e) => {
    const position = e.latlng
    if (marker != null) {
      selector_map.removeLayer(marker)
    }

    document.getElementById('community_location_latitude').value = position.lat
    document.getElementById('community_location_longitude').value = position.lng

    // TODO: i18n this string
    marker = L.marker(position,{ title: 'Community location'}).addTo(selector_map)
  })
}
