$(document).on('turbolinks:load', () => {

  function findMeDistance() {
    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(success, failure);
    } else {
      toastr.error(geo_not_supported, '', { closeButton: true, progressBar: true, positionClass: 'toast-bottom-right' })
    }

    function success(position) {
      const latitude  = position.coords.latitude;
      const longitude = position.coords.longitude;
      let distance = document.getElementById("distance").value
      $.ajax({
        url: "/geolocalise",
        dataType: "json",
        data: { latitude: latitude, longitude: longitude, distance: distance },
        method: 'GET',
        success: (data) => {
          mymap.setView([latitude,longitude], 12)
          let gardens = data.garden
          if (gardens.length > 0){
            gardens.forEach(obj =>{
              let marker = L.marker([obj.latitude, obj.longitude]).addTo(mymap);

              let contener = document.createElement("div")

              let title = document.createElement("h5")
              title.innerHTML = obj.name
              contener.appendChild(title)

              let p = document.createElement("p")
              p.innerHTML = obj.description
              contener.appendChild(p)

              let link = document.createElement("a")
              link.innerHTML = "Visit the garden"
              link.href = data.url + obj.garden_id
              link.setAttribute('target', '_blank');
              contener.appendChild(link)

              marker.bindPopup(contener)
          })
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

  let locate_garden = document.querySelector('#locate-me-gardens')
  if (locate_garden !== null){
    locate_garden.addEventListener('click', findMeDistance)
  }

  let search_button_garden = document.querySelector("#search-button-gardens")
  if (search_button_garden !== null){
    search_button_garden.addEventListener("click", findAddressDistance)
  }

  function findAddressDistance(){
    let address = document.getElementById("search-address").value
    let distance = document.getElementById("distance").value
    if (address != ""){
      $.ajax({
        url: "/geolocalise_address",
        dataType: "json",
        data: { address: address, distance: distance },
        method: 'GET',
        success: (data) => {
          let gardens = data.garden
          if (gardens == undefined || gardens == null){
            toastr.warning(data.message, '', { closeButton: true, progressBar: true, positionClass: 'toast-bottom-right' })
          }
          else {
            mymap.setView([data.latitude,data.longitude], 12)
            if (gardens.length > 0){
              gardens.forEach(obj =>{
                let marker = L.marker([obj.latitude, obj.longitude]).addTo(mymap);
                let contener = document.createElement("div")

                let title = document.createElement("h5")
                title.innerHTML = obj.name
                contener.appendChild(title)

                let p = document.createElement("p")
                p.innerHTML = obj.description
                contener.appendChild(p)

                let link = document.createElement("a")
                link.innerHTML = "Visit the garden"
                link.href = data.url + obj.garden_id
                link.setAttribute('target', '_blank');
                contener.appendChild(link)

                marker.bindPopup(contener)
              })
            }
            else {
              toastr.warning(data.message, '', { closeButton: true, progressBar: true, positionClass: 'toast-bottom-right' })
            }
          }
        }
      })
    }
  }

  let mymap
  if (document.getElementById('map_garden')){
    mymap = L.map('map_garden').setView([45.485, -73.59], 12);
    L.tileLayer('https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}', {
      attribution: 'Map data &copy; <a href="https://www.openstreetmap.org/">OpenStreetMap</a> contributors, <a href="https://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="https://www.mapbox.com/">Mapbox</a>',
      maxZoom: 18,
      id: 'mapbox/streets-v11',
      tileSize: 512,
      zoomOffset: -1,
      accessToken: 'pk.eyJ1Ijoia2V2ZW44MSIsImEiOiJjazdyNDQ3YXQwYTZzM2twNHJ2M2kxdXFtIn0.Vl_ZHudjkrDMIstvKBn53w'
    }).addTo(mymap);
  }

})
