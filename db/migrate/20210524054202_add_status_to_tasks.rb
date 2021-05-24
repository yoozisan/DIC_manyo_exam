class AddStatusToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :status_name, :string, default: false, null: false
  end
end
