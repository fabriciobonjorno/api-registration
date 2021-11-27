class State < ApplicationRecord
  validates :name, :initials, presence: true, uniqueness: true
  has_many :cities, dependent: :destroy
end
