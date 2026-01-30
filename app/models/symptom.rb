class Symptom < ApplicationRecord
    validates :name, presence: true
end
