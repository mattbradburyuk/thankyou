namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_thankyous
    # make_microposts
    # make_relationships
  end

  task pop2users: :environment do
    User.create(name:     "Matt",
                       email:    "m@b.com",
                       password: "foobar",
                       password_confirmation: "foobar",
                       admin: true)

    User.create(name:     "Ruth",
                       email:    "r@b.com",
                       password: "foobar",
                       password_confirmation: "foobar",
                       admin: true)

  end

end

def make_users
  admin = User.create!(name:     "Example User",
                       email:    "example@railstutorial.org",
                       password: "foobar",
                       password_confirmation: "foobar",
                       admin: true)
  3.times do |n|
    name  = Faker::Name.name
    email = "example-#{n+1}@railstutorial.org"
    password  = "password"
    user = User.create!(name:     name,
                 email:    email,
                 password: password,
                 password_confirmation: password)
    user.created_at = (n+1).hour.ago
    user.updated_at = (n+1).hour.ago
    user.save
  end
end

def make_thankyous

  users = User.all
  10.times do
    message = Faker::Lorem.sentence(5)
    users.each do |user|
      user.thankyous_sent.create!(message: message, recipient: User.find(1+ rand(4)))

    end
  end

  num_tys = Thankyou.count
  num_tys.times do |n|
    ta = rand(30)
    new_time = ta.minutes.ago
    Thankyou.find(n+1).update(created_at: new_time, updated_at: new_time)

  end

  # add time to thankyous + update to both


end

# def make_microposts
#   users = User.all(limit: 6)
#   50.times do
#     content = Faker::Lorem.sentence(5)
#     users.each { |user| user.microposts.create!(content: content) }
#   end
# end
#
# def make_relationships
#   users = User.all
#   user  = users.first
#   followed_users = users[2..50]
#   followers      = users[3..40]
#   followed_users.each { |followed| user.follow!(followed) }
#   followers.each      { |follower| follower.follow!(user) }
# end