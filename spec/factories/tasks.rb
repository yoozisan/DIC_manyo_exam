FactoryBot.define do
  factory :task do
    title { 'task' }
    content { 'task' }
    expired_at {'2021-06-03 06:03:00'}
    status_name { "未着手" }
    priority { 1 }
  end

  factory :task2, class: "Task" do
      title { 'task2' }
      content { 'task2' }
      expired_at { '2021-07-07 07:07:00' }
      status_name { "着手" }
      priority { 2 }
    end

  factory :task3, class: "Task" do
    title { 'task3' }
    content { 'task3' }
    expired_at { '2021-06-16 06:03:00' }
    status_name { "完了" }
    priority { 3 }
  end

end
