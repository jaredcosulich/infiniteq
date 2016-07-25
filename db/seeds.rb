# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

tdd = Topic.create(title: 'Test-Driven Development (TDD)', description: """
Test-Driven Development is a process where a test is written prior to any code and then code is written in order to make that test pass, but nothing more.
""")

whyq = tdd.questions.create(text: 'Why would you do TDD?', details: 'What is the point of TDD? It seems to add cost and reduce flexibility. Why would I bother with it?')
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

pairing = Topic.create(title: 'Pair Programming', description: """
Pair Programming is a software development technique where two software developers sit at the same computer and develop software together.
""")


techq = pairing.questions.create(text: 'How do you technically do pairing?')
techq.answers.create(text: """
You can approach pairing in many different ways (one screen/one keyboard/one mouse, two of each, remote pairing, etc). Ideally you try to create a comfortable environment that facilitates effective communication between the two people. In the past I've found that atleast two keyboards and two mice are valuable and that two screens can help ergonomically.

Pairing remotely can be a bit challenging, but if you can get a high-quality connection I think it is very feasible and you can even forget that you are pairing remotely. There is some benefit to being able to read your pair's body language, but I've never seen that aspect distract a pair too much.
""")

pairing.questions.create(text: 'Do you use the same keyboard?').answers.create(text: """
You can, but I'd recommend using two keyboards and two mice. More here: [How do you technically do pairing?](/questions/#{techq.id})
""")

pairing.questions.create(text: 'What is the best setup for pairing?').answers.create(text: """
Really any setup that is comfortable and facilitates effective communication between the pair is ideal. Some more thoughts here: [How do you technically do pairing?](/questions/#{techq.slug})
""")

expensiveq = pairing.questions.create(text: "Isn't pairing twice as expensive?")
expensiveq.answers.create(text: """
This is a common question. There is clearly a cost associated with having two people work on the same code at the same time, but this cost is offset (and I believe results in savings overall) due to the following observations:

* Collaboration: Software development is complicated. Having someone to discuss the design and implementation of a feature can greatly improve the design and reduce the likelihood of errors. In many companies code reviews are used to bridge this gap, but with pairing there is more opportunity for back and forth during development, further improving code quality.
* Micro-Breaks: Software development is mentally taxing. I personally can't code for 8 hours straight without taking breaks. I frequently get distracted by various websites when I'm wrestling with a design decision and may get sucked into an article, emerging 15 minutes later to return to the work. With a pair you can take micro-breaks, allowing your pair to take the driver's seat while you observe. This gives you a chance to rest a bit without taking an extended break. In general you're much more likely to put in a maximum effort while pairing then while soloing (maybe some people are exceptions to this, but I think organizationally speaking this will hold true).
* Information Transfer: When two people pair program they both become intimately familiar with the code they are designing. This helps to spread information and best practices around the organization and reduces bottlenecks and the possibility of problems when a key employee leaves the organization. When building complex software the added communication that pair programming provides can be invaluable to ensuring everyone on the team is on the same page and the team is resilient as it evolves.
* Error Checking: People do make mistakes when writing code. Having a pair can help ensure that, when you do make a mistake, it is caught quickly and is less likely to waste time. It is not the only reason why pairing is valuable, but it is a valid reason.

In general I've found that these reasons add up to a process that is definitively not 2x more expensive. I personally believe that it may be more cost-effective to pair program, but it is difficult, if not impossible, to prove that.
""")

pairing.questions.create(text: "Isn't pairing just about catching typos?").answers.create(text: """
No, that is a valid benefit or pair programming but there are other, more valuable benefits. More details on those benefits can be found here: [Isn't pairing twice as expensive?](/questions/#{expensiveq.slug})
""")
