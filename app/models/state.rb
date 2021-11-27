class State < ApplicationRecord
  validates :name, :initials, presence: true, uniqueness: true
  validates :initials, length: { maximum: 2 }
  has_many :cities, dependent: :destroy
end
