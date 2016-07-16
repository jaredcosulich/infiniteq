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

whyq = tdd.questions.create(text: 'Why would you do TDD?')
valueq = tdd.questions.create(text: 'What is the value of TDD?')
hardq = tdd.questions.create(text: 'Is it hard to do TDD?')

whya = whyq.answers.create(text: """
There are a lot of reasons you would do tdd:
* Writing a test first provides immediate feedback when you write code. You can immediately see if the code you've written makes the test pass or not.
* It immediately provides feedback about other areas of the code. When you run your tests you can immediately see if your code changes had any unintended consequences in other areas of the code base.
* Writing tests first helps you structure your code in a more compartmentalized fashion, helping to avoid overloaded methods and side effects. In general it helps make your code more readable.
* Your tests act as an active contract with your code. Someone new can look at the tests and better understand the range of inputs and outputs the code expects.
* Writing tests first really helps to ensure your code is well-tested.

Note: some of these reasons have more to testing in general than TDD specifically, but since TDD does tend to encourage more robust testing I included them here.
""")

valueq.answers.create(text: """
I would reference the answer here: [Why would you do TDD?](/#{whya.id})
""")

hardq.answers.create(text: """
There are definitely some challenges associated with TDD.

* Sometimes you aren't quite sure what you are building and you need to do a prototype before you feel comfortable approaching it from a test-first perspective. I'd certainly encourage this and then, once you have a better idea about what you are building then rewrite the existing code by writing tests first.
* I often struggle with TDD simply because I am excited to see what ever I am building exist and so I deprioritize testing the functionality. This often derives from my sense that it will be faster if I don't write tests first, but very often this assumption proves wrong and it would have been faster to write a test first. The test would have provided a rapid feedback loop that would have hastened development time.
* I've heard many people complain about having to change tests as functionality within the product changes. This certainly can be a hassle, but it is relatively easy to change a test while it can be essentially impossible to fully grasp the ramifications of a change within a large codebase without tests. I've rarely felt that burdened by the existence of tests.
* Sometimes you are building something for which good testing frameworks do not yet exist. This makes it very difficult to TDD and I would say this may be a good reason to not TDD, but even then you would likely add a lot of value to the world if you built or contributed to a testing framework...
""")
