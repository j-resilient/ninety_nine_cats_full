# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Cat.destroy_all
ApplicationRecord.connection.reset_pk_sequence!('cats')

10.times do 
    Cat.create({
        name: Faker::Superhero.name,
        color: Cat::CAT_COLORS.sample,
        sex: %w(F M).sample,
        birth_date: Faker::Date.birthday(min_age: 1, max_age: 20)
    })
end