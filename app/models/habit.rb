class Habit < ApplicationRecord
  has_many :habit_completions, dependent: :destroy

  validates :name, presence: true

  scope :ordered, -> { order(:position) }

  def completed_on?(date)
    habit_completions.exists?(completed_on: date)
  end
end
