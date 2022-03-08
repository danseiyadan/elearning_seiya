# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(
  name: "Admin",
  email: "admin@email.com",
  password: "password",
  password_confirmation: "password",
  is_admin: true)
 
99.times do |n|
name = Faker::Name.name
email = "username#{n+1}@email.com"
password = "password"
User.create!(
  name: name,
  email: email,
  password: password,
  password_confirmation: password,
  is_admin: false)
end

20.times do |n|
title = Faker::Hobby.unique.activity
description = Faker::Lorem.sentence(word_count: 10)
Category.create!(
  title: title,
  description: description)
end

categories = Category.all
categories.each do |category|
  category.words.create!([
    {
      content: "#{category.title} - Test 1",
      category_id: category.id,
      choices_attributes: [
        {content: "#{category.title} - Choice 1", is_correct: true},
        {content: "#{category.title} - Choice 2", is_correct: false},
        {content: "#{category.title} - Choice 3", is_correct: false}
      ]
    },
    {
      content: "#{category.title} - Test 2",
      category_id: category.id,
      choices_attributes: [
        {content: "#{category.title} - Choice 1", is_correct: true},
        {content: "#{category.title} - Choice 2", is_correct: false},
        {content: "#{category.title} - Choice 3", is_correct: false}
      ]
    },
    {
      content: "#{category.title} - Test 3",
      category_id: category.id,
      choices_attributes: [
        {content: "#{category.title} - Choice 1", is_correct: true},
        {content: "#{category.title} - Choice 2", is_correct: false},
        {content: "#{category.title} - Choice 3", is_correct: false}
      ]
    },
  ])
end