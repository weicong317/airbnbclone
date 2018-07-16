class Listing < ApplicationRecord
  mount_uploaders :rooms, RoomsUploader

  belongs_to :user
  has_many :reservations, dependent: :destroy

  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true
  validates :address, presence: true
  validates :rooms, presence: true
  validates :country, presence: true
end
