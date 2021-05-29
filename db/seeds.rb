# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(email: 'admin@watchstore.com', password: '123456', password_confirmation: '123456')

Product.create(title: 'Apple Watch', price: 1250, image: 'https://cdn.pixabay.com/photo/2014/07/31/23/00/wristwatch-407096_960_720.jpg')
Product.create(title: 'RADO', price: 5000, image: 'https://cdn.pixabay.com/photo/2015/06/25/17/22/smart-watch-821559_960_720.jpg')
Product.create(title: 'Rolex', price: 15000, image: 'https://cdn.pixabay.com/photo/2017/03/24/19/19/rolex-2171960_960_720.jpg')
