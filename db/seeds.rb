# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

roles = Role.create([
  {
    name: 'admin'
  }
])

users = User.create([
  {
    first_name: "John",
    last_name: "Doe",
    email: "john_doe@example.com",
    password: "test12345",
    password_confirmation: "test12345",
    confirmed_at: DateTime.now,
    roles: [roles.first]
  },
  {
    first_name: "Jane",
    last_name: "Doe",
    email: "jane_doe@example.com",
    password: "test12345",
    password_confirmation: "test12345",
    confirmed_at: DateTime.now
  }
])

locations = Location.create!([
  { longitude: -73.561667, latitude: 45.508889 }, # Montréal
  { longitude: -71.208056, latitude: 46.813889 }, # Québec city
  { longitude: -77.783333, latitude: 48.1 }, # Val-d'Or
  { longitude: 2.352222, latitude: 48.856613 }, # Paris
  {
    house_number: "124",
    road: "Rue Prince-Arthur Est",
    city: "Montreal",
    province: "Quebec",
    country: "Canada",
    postal_code: "H2X 1B5"
  }
])

tomato = Variety.create(
    {
        name: "Tomato",
        description: "The tomato is the edible, often red, berry of the plant Solanum lycopersicum, commonly known as a tomato plant. The species originated in western South America and Central America.",
        latin_name: "Solanum lycopersicum",
        family: "Solanaceae",
        freeze_resistance: false,
        culture_start: Date.parse('2000-03-01'),
        culture_end: Date.parse('2000-09-01'),
        spacing: 60,
        height: 120,
        hardiness_zone: 4,
        germination_time: 5,
        sun_exposure: 2
    }
)

pepper = Variety.create(
    {
        name: "Pepper",
        description: "Bell peppers, Capsicum annuum are a cultivar group of annual or perennial plants in the family Solanaceae grown for their edible fruits. Bell pepper plants are short bushes with woody stems that grow brightly colored fruits.",
        latin_name: "Capsicum annuum",
        family: "Solanaceae",
        freeze_resistance: false,
        culture_start: Date.parse('2000-05-01'),
        culture_end: Date.parse('2000-08-01'),
        spacing: 40,
        height: 100,
        hardiness_zone: 5,
        germination_time: 14,
        sun_exposure: 2
    }
)

pumpkin = Variety.create(
    {
        name: "Pumpkin",
        description: "A pumpkin is a cultivar of winter squash that is round with smooth, slightly ribbed skin, and most often deep yellow to orange in coloration. The thick shell contains the seeds and pulp.",
        latin_name: "Cucurbita pepo",
        family: "Cucurbita",
        freeze_resistance: false,
        culture_start: Date.parse('2000-05-01'),
        culture_end: Date.parse('2000-10-01'),
        spacing: 150,
        height: 30,
        hardiness_zone: 3,
        germination_time: 10,
        sun_exposure: 2
    }
)

sunchoke = Variety.create(
    {
        name: "Jerusalem Artichoke",
        description: "The Jerusalem artichoke, also called sunroot, sunchoke, or earth apple, is a species of sunflower native to central North America. It grows wild in eastern and western North America but is considered an introduced species.",
        latin_name: "Helianthus tuberosus",
        family: "Asteraceae",
        freeze_resistance: false,
        culture_start: Date.parse('2000-05-01'),
        culture_end: Date.parse('2000-12-01'),
        spacing: 40,
        height: 240,
        hardiness_zone: 2,
        germination_time: 14,
        sun_exposure: 1
    }
)


varieties = Variety.create([{
  name: "Beefsteak Tomatoes",
  description: "Beefsteak tomatoes are 10 cm (4 in) or more in diameter, often used for sandwiches and similar applications. Their kidney-bean shape, thinner skin, and shorter shelf life makes commercial use impractical.",
  parent: tomato
},
{
  name: "Plum Tomatoes",
  description: "Plum tomatoes, or paste tomatoes (including pear tomatoes), are bred with a lower water /higher solids content for use in tomato sauce and paste, for canning and sauces and are usually oblong 7–9 cm (3–4 in) long and 4–5 cm (1.6–2.0 in) diameter; like the Roma-type tomatoes, important cultivars in the Sacramento Valley.",
  parent: tomato
},
{
  name: "Cherry Tomatoes",
  description: "Cherry tomatoes are small and round, often sweet tomatoes, about the same 1–2 cm (0.4–0.8 in) size as the wild tomato.",
  parent: tomato
}])


categories = Category.create([
  {
    name: "Fruits",
    description: "The sweet and fleshy product of a tree or other plant that contains seed and can be eaten as food."
  },
  {
    name: "Vegetables",
    description: "A plant or part of a plant used as food, typically as accompaniment to meat or fish, such as a cabbage, potato, carrot, or bean."
  }
])


communities = Community.create([
                                   {
                                       location: locations.first,
                                       variety: tomato,
                                       description: "A place where tomato-lovers reunite, at last"
                                   },
                                   {
                                       location: locations.second,
                                       variety: pepper,
                                       description: "World-wide hot people"
                                   },
                                   {
                                       location: locations.third,
                                       variety: pumpkin,
                                       description: "Spooky community for praised pumpkins"
                                   },
                                   {
                                       location: locations.fourth,
                                       variety: sunchoke,
                                       description: "What's a Jerusalem Artichoke anyway?"
                                   }
])

questions = Question.create([
  {
    title: "Les tomates sont des légumes ou des fruits?",
    content: "J'ai observé que les tomates ont toutes les caractéristiques des fruits mais sont utilisées comme des légumes, alors elles sont le quel des deux?",
    community: communities.first,
    user: users.first
  },
  {
    title: "Mes tomates ne sont pas rouges mais plutôt orange, que faire?",
    content: "J'ai essayé de faire pousser une nouvelle variété de tomate et elle est sortie orangé au lieu du rouge tomate, est-ce normal?",
    community: communities.first,
    user: users.first
  },
  {
    title: "J'ai mangé une tomate verte, vais-je mourir?",
    content: "Je pensais qu'elle était mûre mais finalement elle l'était pas, est-ce grave?",
    community: communities.first,
    user: users.first
  }
])
gardens = Garden.create([{
  user: users.first,
  name: "A Bird's Nest Garden",
  description: "My cozy first garden, where I intend to learn all about tomato culture.",
  location: locations.first
},
{
  user: users.first,
  name: "Gardens of Babylone",
  description: "A more ambitious garden in my neighbour's backyard. *not actually in Babylone.",
  location: locations.fourth
},
{
  user: users.second,
  name: "Patches of Vegetables",
  description: "Small gardens on my property.",
  location: locations.second
}])



garden_varieties = GardenVariety.create([{
  garden: gardens.first,
  variety: varieties.second
},
{
  garden: gardens.first,
  variety: varieties.third
},
{
  garden: gardens.second,
  variety: varieties.first
},
{
  garden: gardens.second,
  variety: varieties.second
}])

markets = Market.create([{
  garden_variety: garden_varieties.first,
  quantity: 15,
  unit: "units"
},
{
  garden_variety: garden_varieties.third,
  quantity: 5,
  unit: "pounds"
},
{
  garden_variety: garden_varieties.fourth,
  quantity: 12,
  unit: "units"
}])

market_notifications = MarketNotification.create([{
  email: "kevenaubin@gmail.com",
  market: markets.first,
  status: 0,
  language: "en"
},
{
  email: "keven081@live.ca",
  market: markets.first,
  status: 0,
  language: "fr"
}])

countries = Country.create([
                               {name: "Anguilla", continent: "North America"},
                               {name: "Antigua and Barbuda", continent: "North America"},
                               {name: "Bahamas", continent: "North America"},
                               {name: "Barbados", continent: "North America"},
                               {name: "Belize", continent: "North America"},
                               {name: "Bermuda", continent: "North America"},
                               {name: "Canada", continent: "North America"},
                               {name: "Cayman Islands", continent: "North America"},
                               {name: "Costa Rica", continent: "North America"},
                               {name: "Cuba", continent: "North America"},
                               {name: "Dominica", continent: "North America"},
                               {name: "Dominican Republic", continent: "North America"},
                               {name: "Greenland", continent: "North America"},
                               {name: "Grenada", continent: "North America"},
                               {name: "Guadeloupe", continent: "North America"},
                               {name: "Guatemala", continent: "North America"},
                               {name: "Haiti", continent: "North America"},
                               {name: "Honduras", continent: "North America"},
                               {name: "Jamaica", continent: "North America"},
                               {name: "Martinique", continent: "North America"},
                               {name: "Mexico", continent: "North America"},
                               {name: "Montserrat", continent: "North America"},
                               {name: "Brades", continent: "North America"},
                               {name: "Navassa Island", continent: "North America"},
                               {name: "Nicaragua", continent: "North America"},
                               {name: "Panama", continent: "North America"},
                               {name: "Puerto Rico", continent: "North America"},
                               {name: "Saba", continent: "North America"},
                               {name: "Saint-Barthélemy", continent: "North America"},
                               {name: "Saint Eustatius", continent: "North America"},
                               {name: "Saint Kitts", continent: "North America"},
                               {name: "Saint Lucia", continent: "North America"},
                               {name: "Saint Martin", continent: "North America"},
                               {name: "Saint Pierre and Miquelon", continent: "North America"},
                               {name: "Saint Vincent and the Grenadines", continent: "North America"},
                               {name: "El Salvador", continent: "North America"},
                               {name: "Turks and Caicos Islands", continent: "North America"},
                               {name: "United States", continent: "North America"},
                               {name: "British Virgin Islands", continent: "North America"},
                               {name: "United States Virgin Islands", continent: "North America"},
                               {name: "Argentina", continent: "South America"},
                               {name: "Aruba", continent: "South America"},
                               {name: "Bolivia", continent: "South America"},
                               {name: "Bonaire", continent: "South America"},
                               {name: "Brazil", continent: "South America"},
                               {name: "Chile", continent: "South America"},
                               {name: "Colombia", continent: "South America"},
                               {name: "Curaçao", continent: "South America"},
                               {name: "Ecuador", continent: "South America"},
                               {name: "Falkland Islands", continent: "South America"},
                               {name: "French Guiana", continent: "South America"},
                               {name: "Guyana", continent: "South America"},
                               {name: "Paraguay", continent: "South America"},
                               {name: "Peru", continent: "South America"},
                               {name: "South Georgia and the South Sandwich Islands", continent: "South America"},
                               {name: "Suriname", continent: "South America"},
                               {name: "Trinidad and Tobago", continent: "South America"},
                               {name: "Uruguay", continent: "South America"},
                               {name: "Venezuela", continent: "South America"},
                               {name: " Algeria", continent: "Africa"},
                               {name: "Angola", continent: "Africa"},
                               {name: "Benin", continent: "Africa"},
                               {name: "Botswana", continent: "Africa"},
                               {name: "Burkina Faso", continent: "Africa"},
                               {name: "Burundi", continent: "Africa"},
                               {name: "Cameroon", continent: "Africa"},
                               {name: "Cape Verde", continent: "Africa"},
                               {name: "Central African Republic", continent: "Africa"},
                               {name: "Ceuta", continent: "Africa"},
                               {name: "Chad", continent: "Africa"},
                               {name: "Comoros", continent: "Africa"},
                               {name: "Congo - Brazzaville", continent: "Africa"},
                               {name: "Congo - Kinshasa", continent: "Africa"},
                               {name: "Côte d 'Ivoire'", continent: "Africa"},
                               {name: "Djibouti", continent: "Africa"},
                               {name: "Egypt", continent: "Africa"},
                               {name: "Equatorial Guinea", continent: "Africa"},
                               {name: "Eritrea", continent: "Africa"},
                               {name: "Ethiopia", continent: "Africa"},
                               {name: "Gabon", continent: "Africa"},
                               {name: "Gambia", continent: "Africa"},
                               {name: "Ghana", continent: "Africa"},
                               {name: "Guinea", continent: "Africa"},
                               {name: "Kenya", continent: "Africa"},
                               {name: "Lesotho", continent: "Africa"},
                               {name: "Liberia", continent: "Africa"},
                               {name: "Libya", continent: "Africa"},
                               {name: "Madagascar", continent: "Africa"},
                               {name: "Malawi", continent: "Africa"},
                               {name: "Mali", continent: "Africa"},
                               {name: "Mauritania", continent: "Africa"},
                               {name: "Mauritius", continent: "Africa"},
                               {name: "Mayotte", continent: "Africa"},
                               {name: "Mamoudzou", continent: "Africa"},
                               {name: "Melilla", continent: "Africa"},
                               {name: "Morocco", continent: "Africa"},
                               {name: "Mozambique", continent: "Africa"},
                               {name: "Namibia", continent: "Africa"},
                               {name: "Niger", continent: "Africa"},
                               {name: "Nigeria", continent: "Africa"},
                               {name: "La Réunion", continent: "Africa"},
                               {name: "Rwanda", continent: "Africa"},
                               {name: "São Tomé and Príncipe", continent: "Africa"},
                               {name: "Senegal", continent: "Africa"},
                               {name: "Seychelles", continent: "Africa"},
                               {name: "Sierra Leone", continent: "Africa"},
                               {name: "Somalia", continent: "Africa"},
                               {name: "South Africa", continent: "Africa"},
                               {name: "Cape Tow", continent: "Africa"},
                               {name: "Pretoria", continent: "Africa"},
                               {name: "Saint Helena", continent: "Africa"},
                               {name: "South Sudan", continent: "Africa"},
                               {name: "Sudan", continent: "Africa"},
                               {name: "Swaziland", continent: "Africa"},
                               {name: "Mbabane", continent: "Africa"},
                               {name: "Tanzania", continent: "Africa"},
                               {name: "Togo", continent: "Africa"},
                               {name: "Tunisia", continent: "Africa"},
                               {name: "Uganda", continent: "Africa"},
                               {name: "Zambia", continent: "Africa"},
                               {name: "Zimbabw", continent: "Africa"},
                               {name: "Akrotiri", continent: "Europe"},
                               {name: "Åland Islands", continent: "Europe"},
                               {name: "Albania", continent: "Europe"},
                               {name: "Andorra", continent: "Europe"},
                               {name: "Armenia", continent: "Europe"},
                               {name: "Austria", continent: "Europe"},
                               {name: "Azerbaijan", continent: "Europe"},
                               {name: "Belarus", continent: "Europe"},
                               {name: "Belgium", continent: "Europe"},
                               {name: "Bosnia and Herzegovina", continent: "Europe"},
                               {name: "Bulgaria", continent: "Europe"},
                               {name: "Croatia", continent: "Europe"},
                               {name: "Cyprus", continent: "Europe"},
                               {name: "Czech Republic", continent: "Europe"},
                               {name: "Denmark", continent: "Europe"},
                               {name: "Dhekelia", continent: "Europe"},
                               {name: "Estonia", continent: "Europe"},
                               {name: "Faroe Islands", continent: "Europe"},
                               {name: "Finland", continent: "Europe"},
                               {name: "France", continent: "Europe"},
                               {name: "Georgia", continent: "Europe"},
                               {name: "Germany", continent: "Europe"},
                               {name: "Gibraltar", continent: "Europe"},
                               {name: "Greece", continent: "Europe"},
                               {name: "Guernsey", continent: "Europe"},
                               {name: "Hungary", continent: "Europe"},
                               {name: "Iceland", continent: "Europe"},
                               {name: "Ireland", continent: "Europe"},
                               {name: "Italy", continent: "Europe"},
                               {name: "Jan Mayen", continent: "Europe"},
                               {name: "Jersey", continent: "Europe"},
                               {name: "Kazakhstan", continent: "Europe"},
                               {name: "Kosovo", continent: "Europe"},
                               {name: "Latvia", continent: "Europe"},
                               {name: "Liechtenstein", continent: "Europe"},
                               {name: "Lithuania", continent: "Europe"},
                               {name: "Luxembourg", continent: "Europe"},
                               {name: "North Macedonia", continent: "Europe"},
                               {name: "Malta", continent: "Europe"},
                               {name: "Moldova", continent: "Europe"},
                               {name: "Monaco", continent: "Europe"},
                               {name: "Montenegro", continent: "Europe"},
                               {name: "Netherlands", continent: "Europe"},
                               {name: "Norway", continent: "Europe"},
                               {name: "Poland", continent: "Europe"},
                               {name: "Portugal", continent: "Europe"},
                               {name: "Romania", continent: "Europe"},
                               {name: "Russia", continent: "Europe"},
                               {name: "San Marino", continent: "Europe"},
                               {name: "Serbia", continent: "Europe"},
                               {name: "Slovakia", continent: "Europe"},
                               {name: "Slovenia", continent: "Europe"},
                               {name: "Spain", continent: "Europe"},
                               {name: "Svalbard", continent: "Europe"},
                               {name: "Sweden", continent: "Europe"},
                               {name: "Switzerland", continent: "Europe"},
                               {name: "Turkey", continent: "Europe"},
                               {name: "Ukraine", continent: "Europe"},
                               {name: "United Kingdom", continent: "Europe"},
                               {name: "Vatican", continent: "Europe"},
                               {name: "Afghanistan", continent: "Asia"},
                               {name: "Armenia", continent: "Asia"},
                               {name: "Azerbaijan", continent: "Asia"},
                               {name: "Bahrain", continent: "Asia"},
                               {name: "Bangladesh", continent: "Asia"},
                               {name: "Bhutan", continent: "Asia"},
                               {name: "Brunei", continent: "Asia"},
                               {name: "Myanmar", continent: "Asia"},
                               {name: "Cambodia", continent: "Asia"},
                               {name: "China", continent: "Asia"},
                               {name: "Cyprus", continent: "Asia"},
                               {name: "East Timor", continent: "Asia"},
                               {name: "Georgia", continent: "Asia"},
                               {name: "India", continent: "Asia"},
                               {name: "Indonesia", continent: "Asia"},
                               {name: "Iran", continent: "Asia"},
                               {name: "Iraq", continent: "Asia"},
                               {name: "Israel", continent: "Asia"},
                               {name: "Japan", continent: "Asia"},
                               {name: "Jordan", continent: "Asia"},
                               {name: "Kazakhstan", continent: "Asia"},
                               {name: "Kuwait", continent: "Asia"},
                               {name: "Kyrgyzstan", continent: "Asia"},
                               {name: "Laos", continent: "Asia"},
                               {name: "Lebanon", continent: "Asia"},
                               {name: "Malaysia", continent: "Asia"},
                               {name: "Maldives", continent: "Asia"},
                               {name: "Mongolia", continent: "Asia"},
                               {name: "Nepal", continent: "Asia"},
                               {name: "North Korea", continent: "Asia"},
                               {name: "Oman", continent: "Asia"},
                               {name: "Pakistan", continent: "Asia"},
                               {name: "Palestine", continent: "Asia"},
                               {name: "Philippines", continent: "Asia"},
                               {name: "Qatar", continent: "Asia"},
                               {name: "Russia", continent: "Asia"},
                               {name: "Saudi Arabia", continent: "Asia"},
                               {name: "Singapore", continent: "Asia"},
                               {name: "Sri Lanka", continent: "Asia"},
                               {name: "South Korea", continent: "Asia"},
                               {name: "Syria", continent: "Asia"},
                               {name: "Taiwan", continent: "Asia"},
                               {name: "Tajikistan", continent: "Asia"},
                               {name: "Thailand", continent: "Asia"},
                               {name: "Turkey", continent: "Asia"},
                               {name: "Turkmenistan", continent: "Asia"},
                               {name: "United Arab Emirates", continent: "Asia"},
                               {name: "Uzbekistan", continent: "Asia"},
                               {name: "Vietnam", continent: "Asia"},
                               {name: "Yemen", continent: "Asia"},
                               {name: "American Samoa", continent: "Oceania"},
                               {name: "Australia", continent: "Oceania"},
                               {name: "Baker Island", continent: "Oceania"},
                               {name: "Clipperton Island", continent: "Oceania"},
                               {name: "Papeete", continent: "Oceania"},
                               {name: "Cook Islands", continent: "Oceania"},
                               {name: "Easter Island", continent: "Oceania"},
                               {name: "Fiji", continent: "Oceania"},
                               {name: "French Polynesia", continent: "Oceania"},
                               {name: "Guam", continent: "Oceania"},
                               {name: "Hawaii", continent: "Oceania"},
                               {name: "Howland Island", continent: "Oceania"},
                               {name: "Jarvis Island", continent: "Oceania"},
                               {name: "Johnston Atoll", continent: "Oceania"},
                               {name: "Kingman Reef", continent: "Oceania"},
                               {name: "Kiribati", continent: "Oceania"},
                               {name: "Macquarie Island", continent: "Oceania"},
                               {name: "Marshall Islands", continent: "Oceania"},
                               {name: "Micronesia", continent: "Oceania"},
                               {name: "Midway Atoll", continent: "Oceania"},
                               {name: "Minami - Tori", continent: "Oceania"},
                               {name: "Nauru", continent: "Oceania"},
                               {name: "New Caledonia", continent: "Oceania"},
                               {name: "New Zealand", continent: "Oceania"},
                               {name: "Niue", continent: "Oceania"},
                               {name: "Norfolk", continent: "Oceania"},
                               {name: "Northern Mariana Islands", continent: "Oceania"},
                               {name: "Palau", continent: "Oceania"},
                               {name: "Palmyra Atoll", continent: "Oceania"},
                               {name: "Papua New Guinea", continent: "Oceania"},
                               {name: "Pitcairn", continent: "Oceania"},
                               {name: "Samoa", continent: "Oceania"},
                               {name: "Solomon Islands", continent: "Oceania"},
                               {name: "Tokelau", continent: "Oceania"},
                               {name: "Tonga", continent: "Oceania"},
                               {name: "Tuvalu", continent: "Oceania"},
                               {name: "Vanuatu", continent: "Oceania"},
                               {name: "Wake Island", continent: "Oceania"},
                               {name: "Wallis and Futuna", continent: "Oceania"},
                           ])
