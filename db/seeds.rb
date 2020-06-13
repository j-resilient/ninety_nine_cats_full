# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Cat.destroy_all
CatRentalRequest.destroy_all
User.destroy_all
ApplicationRecord.connection.reset_pk_sequence!('cats')
ApplicationRecord.connection.reset_pk_sequence!('cat_rental_requests')
ApplicationRecord.connection.reset_pk_sequence!('users')

next_year = Date.today.next_year.year.to_s

10.times do 
    user = User.create({
        user_name: Faker::Name.first_name, 
        password: "password"
    })
    cat = Cat.create({
        name: Faker::Superhero.name,
        color: Cat::CAT_COLORS.sample,
        sex: %w(F M).sample,
        birth_date: Faker::Date.birthday(min_age: 1, max_age: 20), 
        user_id: user.id
    })

    CatRentalRequest.create({
        cat_id: cat.id,
        start_date: Date.parse("#{next_year}-01-01"),
        end_date: Date.parse("#{next_year}-01-06")
    })
end