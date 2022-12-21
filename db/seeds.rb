# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
drama = Category.create title: "Drama"
detective = Category.create title: "Detective"
33.times do |i|
  if i % 2 == 1
    Movie.create title: "Title № #{i}", description: "some description" * 15, category_id: detective.id, average_rating: i / 3
  else
    Movie.create title: "Title № #{i}", description: "some description" * 15, category_id: drama.id, average_rating: i / 3
  end
end
