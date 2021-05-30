# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(email: 'admin@watchstore.com', password: '123456', password_confirmation: '123456')

Product.create(title: 'Apple Watch', price: 1250, image: 'https://images.unsplash.com/photo-1546868871-7041f2a55e12?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=700&q=80')
Product.create(title: 'RADO', price: 5000, image: 'https://images.unsplash.com/photo-1539874754764-5a96559165b0?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1102&q=80')
Product.create(title: 'Rolex', price: 15000, image: 'https://images.pexels.com/photos/47856/rolex-wrist-watch-clock-gmt-47856.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940')
Product.create(title: 'Guess', price: 3500, image: 'https://cdn.pixabay.com/photo/2020/08/01/14/12/watch-5455474_960_720.jpg')
Product.create(title: 'Fossil', price: 4300, image: 'https://cdn.pixabay.com/photo/2020/02/16/08/59/fossil-4852930_960_720.jpg')
Product.create(title: 'Timex', price: 1100, image: 'https://cdn.pixabay.com/photo/2014/06/18/13/23/time-371226_960_720.jpg')
Product.create(title: 'Diesel', price: 8500, image: 'https://cdn.pixabay.com/photo/2020/09/19/00/57/watch-5583188_960_720.jpg')





