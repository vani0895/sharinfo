require "json"
require "rest-client"

Post.destroy_all
Comment.destroy_all
User.destroy_all

user = User.create!(
  email: 'test@test.com',
  password: 'azerty',
  password_confirmation: 'azerty',
  name: 'Elsa'
)

TOP_STORIES_URL = "https://hacker-news.firebaseio.com/v0/topstories.json"

def story_url(id)
  "https://hacker-news.firebaseio.com/v0/item/#{id}.json"
end

post_ids = JSON.parse(RestClient.get(TOP_STORIES_URL))

post_ids.take(10).each do |id|
  hacker_news_post = JSON.parse(RestClient.get(story_url(id)))
  post = user.posts.create!(
    title: hacker_news_post["title"],
    content: hacker_news_post["text"] || "No content available",
    url: hacker_news_post["url"]
  )
  post.save
  puts "#{post.title} - #{post.url}"
end
