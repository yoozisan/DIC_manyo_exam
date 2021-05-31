# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

name = "kawa"
email = "kawa@kawa.com"
password = "kawakawa"
User.create!(name: "管理者",
             email: "admin@admin.com",
             password_digest: "111111",
             password: "111111",
             password_confirmation: "111111",
             admin: true
             )

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
