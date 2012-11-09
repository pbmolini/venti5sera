namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_admin
    make_users
    make_desires
    #make_relationships
  end
end

def make_admin
  # this first user is the admin
  admin = User.create!(name: "Example Admin",
                       email: "admin@example.com",
                       password: "foobar",
                       password_confirmation: "foobar")
  admin.toggle!(:admin) # we set this way because it is not attr_accessible
end

def make_users
  # create other users
  49.times do |n|
    name  = Faker::Name.name
    email = "example-#{n+1}@example.com"
    password  = "password"
    User.create!(name: name,
                 email: email,
                 password: password,
                 password_confirmation: password)
  end
end

def make_desires

  # create 50 desires for the firs 6 users
  users = User.all(limit: 6)
  25.times do
    content = Faker::Lorem.sentence(5)
    users.each { |user| user.desires.create!(content: content)}
  end
end

def make_relationships
  users = User.all
  user = users.first
  followed_users = users[2..50]
  followers = users [3..40]
  followed_users.each { |followed| user.follow!(followed) }
  followers.each { |follower| follower.follow!(user) }
end

