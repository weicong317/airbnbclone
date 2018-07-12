user = {}
user['password'] = 'asdf'

ActiveRecord::Base.transaction do
  20.times do
    user['name'] = Faker::Name.name
    user['username'] = Faker::App.name
    user['email'] = Faker::Internet.email
    user['role'] = 1

    User.create(user)
  end
end 

# Seed Listings
listing = {}
uids = []
User.all.each { |u| uids << u.id }

ActiveRecord::Base.transaction do
  40.times do
    listing['name'] = Faker::App.name
    listing['address'] = Faker::Address.street_address
    listing['price'] = rand(80..500)
    listing['description'] = Faker::Hipster.sentence
    listing['verification'] = Faker::Boolean
    listing['country'] = "Malaysia"

    listing['user_id'] = uids.sample

    Listing.create(listing)
  end
end