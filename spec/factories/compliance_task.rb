# spec/factories/compliance_tasks.rb
FactoryBot.define do
  factory :compliance_task do
    title { "Sample Compliance Task" }
    status { "pending" }
    description { "This is a sample compliance task description." }
    due_date { Date.today + 7.days }
  end
end
