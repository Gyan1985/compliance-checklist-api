class CreateComplianceTasks < ActiveRecord::Migration[8.0]
  def change
    create_table :compliance_tasks do |t|
      t.string :title
      t.text   :description
      t.date  :due_date
      t.string :status
      
      t.timestamps
    end
  end
end
