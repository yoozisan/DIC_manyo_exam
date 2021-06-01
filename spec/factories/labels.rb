FactoryBot.define do
  factory :label do
    name { "ルンピニー" }
  end
  factory :label2, class: "Label" do
    name { "トップキング" }
  end
  factory :label3, class: "Label" do
    name { "ヨッカオ" }
  end
end
