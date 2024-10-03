# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

5.times do
  User.create!(last_name: Faker::Name.last_name,
              first_name: Faker::Name.first_name,
              nickname: Faker::TvShows::Friends.character,
              email: Faker::Internet.unique.email,
              password: "password",
              password_confirmation: "password")
end

user_ids = User.ids

10.times do |index|
  user = User.find(user_ids.sample)
  user.articles.create!(caption: "キャプションです#{index}", image_url: "article_placeholder.png", is_public: 0, is_winner: 0)
end
