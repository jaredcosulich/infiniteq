# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

tdd = Topic.create(title: 'Test-Driven Development (TDD)', description: """
Test-Driven Development is a process where a test is written prior to any code and then
code is written in order to make that test pass, but nothing more.
""")

tdd.questions.create('Why would you do TDD?')
tdd.questions.create('What is the value of TDD?')
tdd.questions.create('Is it hard to do TDD?')
