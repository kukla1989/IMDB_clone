# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
categories = %w{Horror Western Documentary Comedy Action Fantasy Mystery Fiction Romance}
categories.each { |title| Category.create(title: title) }
33.times do
    Movie.create title: Faker::Movie.title, description: Faker::Lorem.sentence(word_count: 20),
                 category: Category.all.sample(1)[0], average_rating: 9
end
User.create(email: "admin@mail.com", admin:true, password: "romaro")
User.create(email: "user@mail.com", password: "romaro")
