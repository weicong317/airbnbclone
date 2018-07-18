class Listing < ApplicationRecord
  mount_uploaders :rooms, RoomsUploader

  belongs_to :user
  has_many :reservations, dependent: :destroy

  scope :country, -> (country) { where(country: country) }
  scope :price, -> (price) { where("price <= ?", price) }
  scope :amenities, -> (amenities) { where("amenities @> ARRAY[?]", amenities) }
  scope :verification, -> { where(verification: true) }
  scope :starts_with, -> (country) { where("country ILIKE ?", "#{country}%")}

  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true
  validates :address, presence: true
  validates :rooms, presence: true
  validates :country, presence: true
end
