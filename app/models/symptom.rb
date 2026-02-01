class Symptom < ApplicationRecord
    validates :name, presence: true
    validate :observed_to_after_observed_from

    private

    def observed_to_after_observed_from
      return if observed_from.blank? || observed_to.blank?
      
      if observed_to <= observed_from
        errors.add(:observed_to, "must be after observed from")
      end
    end
end
