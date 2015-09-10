namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    puts "Populating the database..."
    make_users
    make_posts
    make_relationships
  end
end

def make_users
  admin = User.create!(name: "Luigi De Russis",
                       email: "luigi.derussis@polito.it",
                       password: "lam-2015",
                       password_confirmation: "lam-2015")
  admin.toggle!(:admin)
  puts "... the admin user has been created"
  99.times do |n|
    name  = Faker::Name.name
    email = "example-#{n+1}@corsa.polito.it"
    password  = "password"
    User.create!(name: name,
                 email: email,
                 password: password,
                 password_confirmation: password)
  end
  puts "... 99 users have been created"
end

def make_posts
  # generate 50 fake posts for the first 10 users
  users = User.all(limit: 10)
  50.times do
    post_title = Faker::Lorem.sentence(3)
    post_content = Faker::Lorem.paragraph
    users.each { |user| user.posts.create!(title: post_title, content: post_content )}
  end
  puts "... 50 posts for the first 10 users have been created"
end

def make_relationships
  users = User.all
  user = users.first
  followed_users = users[2..50]
  followers = users[3..40]
  # first user follows user 3 up to 51
  followed_users.each { |followed| user.follow!(followed) }
  puts "... the first user follows user 3 to 51, now!"
  # users 4 up to 41 follow back the first user
  followers.each { |follower| follower.follow!(user) }
  puts "... the first user is followed by user 4 to 41, now!"
end