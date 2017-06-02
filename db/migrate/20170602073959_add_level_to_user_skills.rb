class AddLevelToUserSkills < ActiveRecord::Migration[5.1]
  def change
    add_column :user_skills, :level, :integer, default: 0
    add_index :user_skills, :level
  end
end
