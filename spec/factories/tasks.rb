FactoryBot.define do
  factory :task do
    title { 'test_title' }
    content { 'test_content' }
    expired_at {'2021-06-03 06:03:00'}
  end
end
