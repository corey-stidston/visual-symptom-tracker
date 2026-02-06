class Problem < ApplicationRecord
  has_many :observations, dependent: :destroy
end
