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
  }
])

locations = Location.create([
  { longitude: -73.561667, latitude: 45.508889 }, # Montréal
  { longitude: -71.208056, latitude: 46.813889 }, # Québec city
  { longitude: -77.783333, latitude: 48.1 }, # Val-d'Or
  { longitude: 2.352222, latitude: 48.856613 } # Paris
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
