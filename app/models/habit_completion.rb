class HabitCompletion < ApplicationRecord
  belongs_to :habit

  validates :completed_on, presence: true, uniqueness: { scope: :habit_id }
end
