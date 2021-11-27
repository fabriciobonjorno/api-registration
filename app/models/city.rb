class City < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  belongs_to :state
end
