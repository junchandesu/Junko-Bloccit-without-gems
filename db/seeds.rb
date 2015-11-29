 # Rails' seeding feature allows the database to be populated with initial data based on the contents of seeds.rb.

 include RandomData  #crated under library 

 # Create Users
 5.times do
 	user = User.create!(
 		name: RandomData.random_name, 
 		email: RandomData.random_email,
 		password: RandomData.random_sentence

 		)
 end
 users = User.all

 # Create Topics
 15.times do
 	Topic.create!(
 		name:        RandomData.random_sentence,
 		description: RandomData.random_paragraph
 		)
 end
 topics = Topic.all
 
 # Create Posts
 50.times do
   Post.create!(  #create! with a bang (!). Adding a ! instructs the method to raise an error if there's a problem with the data being seeded. Using create without a bang could fail silently, causing the error to surface later.
     title:  RandomData.random_sentence,
     body:   RandomData.random_paragraph,
     topic: topics.sample,
     user: users.sample
   )
 end

 # only create unique record 
 Post.find_or_create_by(
 	title: "Jace's title",
 	body: "Jace's body",
 	topic: topics.sample
 	)
 posts = Post.all
 
 # Create Comments
 100.times do
   Comment.create!(
     post: posts.sample,
     body: RandomData.random_paragraph,
     # user: users.sample
   )
 end

 user = User.first
 user.update_attributes!(
 	email: 'aliciajace@gmail.com',
 	password: 'password'
 )

  # Create an admin user
 admin = User.create!(
   name:     'Admin User',
   email:    'admin@example.com',
   password: 'helloworld',
   role:     'admin'
 )
 
 # Create a member
 member = User.create!(
   name:     'Member User',
   email:    'member@example.com',
   password: 'helloworld'
 )
 
 puts "Seed finished"
 puts "#{User.count} users created"
 puts "#{Topic.count} topics created"
 puts "#{Post.count} posts created"
 puts "#{Comment.count} comments created"