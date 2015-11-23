 # Rails' seeding feature allows the database to be populated with initial data based on the contents of seeds.rb.

 include RandomData  #crated under library 

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
     topic: topics.sample
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
     body: RandomData.random_paragraph
   )
 end
 
 puts "Seed finished"
 puts "#{Topic.count} topics created"
 puts "#{Post.count} posts created"
 puts "#{Comment.count} comments created"