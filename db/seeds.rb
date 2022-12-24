categories = %w{Horror Western Documentary Comedy Action Fantasy Mystery Fiction Romance}
categories.each { |title| Category.create(title: title) }
33.times do
    Movie.create title: Faker::Movie.title, description: Faker::Lorem.sentence(word_count: 20),
                 category: Category.all.sample(1)[0], average_rating: 9
end
User.create(email: "admin@mail.com", admin:true, password: "romaro")
User.create(email: "user@mail.com", password: "romaro")
