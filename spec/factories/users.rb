FactoryBot.define do
  factory :user do
    name { "user1" }
    email { "user1@user1.com" }
    password { "111111" }
    password_confirmation { "111111" }
    admin { "一般" }
  end
  factory :admin_user, class: "User" do
    name { "user2"}
    email { "user2@user2.com"}
    password { "222222"}
    password_confirmation { "222222" }
    admin { "管理者"}
  end
end
