class User < ApplicationRecord
  include Clearance::User

  mount_uploader :avatar, AvatarUploader

  has_many :listings, dependent: :destroy
  has_many :reservations, dependent: :destroy
  has_many :authentications, dependent: :destroy

  validates :role, presence: true

  def self.create_with_auth_and_hash(authentication, auth_hash)
    user = self.create!(
      role: 2,
      name: auth_hash["info"]["name"],
      username: auth_hash["info"]["first_name"],
      email: auth_hash["info"]["email"],
      password: SecureRandom.hex(10),
      avatar_url: auth_hash["info"]["image"]
    )
    user.authentications << authentication
    return user
  end
 
  # grab google to access google for user data
  def google_token
    x = self.authentications.find_by(provider: 'google_oauth2')
    return x.token unless x.nil?
  end

  enum role: [:admin, :moderator, :customer]
end
