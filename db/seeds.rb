# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

users = User.create([
  {
    first_name: 'John',
    last_name: 'Doe',
    email: 'john_doe@example.com',
    password: 'test12345',
    password_confirmation: 'test12345',
    confirmed_at: DateTime.now
  },
  {
    first_name: 'Jane',
    last_name: 'Doe',
    email: 'jane_doe@example.com',
    password: 'test12345',
    password_confirmation: 'test12345',
    confirmed_at: DateTime.now
  }
])

locations = Location.create!([
  { longitude: -73.561667, latitude: 45.508889 }, # Montréal
  { longitude: -71.208056, latitude: 46.813889 }, # Québec city
  { longitude: -77.783333, latitude: 48.1 }, # Val-d'Or
  { longitude: 2.352222, latitude: 48.856613 }, # Paris
  {
    house_number: '124',
    road: "Rue Prince-Arthur Est",
    city: "Montreal",
    province: "Quebec",
    country: "Canada",
    postal_code: "H2X 1B5"
  }
])

regions = Region.create([
  { name: "Montréal", location: locations.first },
  { name: "Québec", location: locations.second },
  { name: "Val-d'Or", location: locations.third },
  { name: "Paris", location: locations.fourth }
])

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

produce = Produce.create([
  {
    name: "Tomatoes",
    description: "Glossy red, or occasionally yellow, pulpy edible fruits that are eaten as vegetables or in salads.",
    categories: [categories.first, categories.second]
  }
])

communities = Community.create([
  region: regions.first,
  produce: produce.first
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

varieties = Variety.create([{
  name: "Beefsteak Tomatoes",
  description: "Beefsteak tomatoes are 10 cm (4 in) or more in diameter, often used for sandwiches and similar applications. Their kidney-bean shape, thinner skin, and shorter shelf life makes commercial use impractical.",
  produce: produce.first
},
{
  name: "Plum Tomatoes",
  description: "Plum tomatoes, or paste tomatoes (including pear tomatoes), are bred with a lower water /higher solids content for use in tomato sauce and paste, for canning and sauces and are usually oblong 7–9 cm (3–4 in) long and 4–5 cm (1.6–2.0 in) diameter; like the Roma-type tomatoes, important cultivars in the Sacramento Valley.",
  produce: produce.first
},
{
  name: "Cherry Tomatoes",
  description: "Cherry tomatoes are small and round, often sweet tomatoes, about the same 1–2 cm (0.4–0.8 in) size as the wild tomato.",
  produce: produce.first
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

