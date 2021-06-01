# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

name = "kawa"
email = "kawa@dic.com"
password = "kawakawa"
User.create!(name: "管理者",
             email: "admin@dic.com",
             password_digest: "111111",
             password: "111111",
             password_confirmation: "111111",
             admin: true
             )
 10.times do |n|
   name = Faker::Games::Pokemon.name
   email = Faker::Internet.email
   password = "password"
   User.create!(name: name,
                email: email,
                password: password,
                password_confirmation: password,
                admin: false
                )
 end

Label.create!(
  [
    {name: 'ルンピニー'},
    {name: 'ラジャ'},
    {name: 'ツインズ'},
    {name: 'ヨッカオ'},
    {name: 'ブーン'},
    {name: 'フェノム'},
    {name: 'トップキング'},
    {name: 'ウィンディ'},
    {name: 'フェアテックス'},
    {name: 'ヴェナム'}
  ]
)

10.times do |n|
  title = Faker::Games::Pokemon.move
  content = Faker::Games::Pokemon.location
  expired_at = Faker::Date.between(from: '2021-05-27', to: '2021-09-27')
  user_id = n + 1
  Task.create!(title: title,
               content: content,
               expired_at: expired_at,
               user_id: user_id,
               )
end
