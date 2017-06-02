class User < ApplicationRecord
  has_many :user_skills
  has_many :skills,
    through: :user_skills

  after_create do
    Skill.all.each do |skill|
      self.user_skills.create skill: skill
    end
  end
end
