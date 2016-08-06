Topic.create!([
  #1
  {title: "Software Development", description: "An umbrella topic for all software-development-related subtopics and questions.", user_id: nil, slug: "software-development", parent_topic_id: nil, questions_count: 1, recursive_questions_count: 25, recursive_subtopic_ids: "1,2,5,6,7,8,11,12,13,14,15"},

  #2
  {title: "Ruby on Rails", description: "Questions regarding the Ruby on Rails software development framework.", user_id: nil, slug: "ruby-on-rails", parent_topic_id: 1, questions_count: 5, recursive_questions_count: 8, recursive_subtopic_ids: "6,8,11"},
  {title: "Coffeescript", description: "For all questions regarding the usage of coffeescript in Ruby on Rails.", user_id: nil, slug: "coffeescript", parent_topic_id: 2, questions_count: 1, recursive_questions_count: 1, recursive_subtopic_ids: ""},
  {title: "User Authentication", description: "Questions about user authentication (when a user signs up, logs in, resets their password, etc) in Ruby on Rails.", user_id: nil, slug: "user-authentication", parent_topic_id: 2, questions_count: 1, recursive_questions_count: 1, recursive_subtopic_ids: ""},

  #5
  {title: "Databases", description: "Questions regarding databases used in software projects. Specific subtopics exist for each type of database (or create one).", user_id: nil, slug: "databases", parent_topic_id: 1, questions_count: 0, recursive_questions_count: 1, recursive_subtopic_ids: "15"},
  {title: "Postgres", description: "Questions about the Postgres database.", user_id: nil, slug: "postgres", parent_topic_id: 5, questions_count: 1, recursive_questions_count: 1, recursive_subtopic_ids: ""},

  #7
  {title: "Pair Programming", description: "\nPair Programming is a software development technique where two software developers sit at the same computer and develop software together.\n", user_id: nil, slug: "pair-programming", parent_topic_id: 1, questions_count: 7, recursive_questions_count: 7, recursive_subtopic_ids: ""},

  #8
  {title: "Test-Driven Development (TDD)", description: "\nTest-Driven Development is a process where a test is written prior to any code and then code is written in order to make that test pass, but nothing more.\n", user_id: nil, slug: "test-driven-development-tdd", parent_topic_id: 1, questions_count: 4, recursive_questions_count: 4, recursive_subtopic_ids: ""},

  #9
  {title: "Markdown", description: "Markdown is a way to write html using text that is not html. A further description of it can be found here:\r\n\r\n[Daring Fireball: Markdown](https://daringfireball.net/projects/markdown/)", user_id: nil, slug: "markdown", parent_topic_id: 1, questions_count: 0, recursive_questions_count: 1, recursive_subtopic_ids: "13"},
  {title: "Redcarpet Ruby Library", description: "Questions about the Redcarpet Markdown Ruby Library: [Github:Redcarpet](https://github.com/vmg/redcarpet)", user_id: nil, slug: "redcarpet-ruby-library", parent_topic_id: 9, questions_count: 1, recursive_questions_count: 1, recursive_subtopic_ids: ""},

  #11
  {title: "State Machines", description: "Questions about the concept and usage of state machines in software development.", user_id: nil, slug: "state-machines", parent_topic_id:1, questions_count: 3, recursive_questions_count: 3, recursive_subtopic_ids: ""},
  {title: "Acts As State Machine (AASM) Gem", description: "Questions regarding the AASM gem: [AASM Github Project Page](https://github.com/aasm/aasm)", user_id: nil, slug: "acts-as-state-machine-aasm-gem", parent_topic_id: 11, questions_count: 1, recursive_questions_count: 1, recursive_subtopic_ids: ""},

  #13
  {title: "Design", description: "Umbrella topic for all design-related questions.", user_id: nil, slug: "design", parent_topic_id: nil, questions_count: 0, recursive_questions_count: 1, recursive_subtopic_ids: "10"},
  {title: "Web Design", description: "Umbrella topic for all questions about web design (design of websites).", user_id: nil, slug: "web-design", parent_topic_id: 13, questions_count: 1, recursive_questions_count: 1, recursive_subtopic_ids: ""},

  #15
  {title: "InfiniteQ", description: "Everything you ever wanted to ask about this website. ", user_id: nil, slug: "infiniteq", parent_topic_id: nil, questions_count: 9, recursive_questions_count: 9, recursive_subtopic_ids: ""},

  #16
  {title: "Diet", description: "An umbrella topic for all questions related to diet.", user_id: nil, slug: "diet", parent_topic_id: nil, questions_count: 1, recursive_questions_count: 1, recursive_subtopic_ids: ""}
])

Question.create!([
  #1
  {text: "Why would you do TDD?", details: "What is the point of TDD? It seems to add cost and reduce flexibility. Why would I bother with it?", topic_id: 8, user_id: nil, slug: "why-would-you-do-tdd", aasm_state: "verified", answers_count: 1},
  {text: "What is the value of TDD?", details: nil, topic_id: 8, user_id: nil, slug: "what-is-the-value-of-tdd", aasm_state: "verified", answers_count: 1},
  #3
  {text: "Is it hard to do TDD?", details: nil, topic_id: 8, user_id: nil, slug: "is-it-hard-to-do-tdd", aasm_state: "verified", answers_count: 1},
  {text: "How do you technically do pairing?", details: nil, topic_id: 7, user_id: nil, slug: "how-do-you-technically-do-pairing", aasm_state: "verified", answers_count: 1},
  #5
  {text: "Do you use the same keyboard?", details: nil, topic_id: 7, user_id: nil, slug: "do-you-use-the-same-keyboard", aasm_state: "verified", answers_count: 1},
  {text: "What is the best setup for pairing?", details: nil, topic_id: 7, user_id: nil, slug: "what-is-the-best-setup-for-pairing", aasm_state: "verified", answers_count: 1},
  #7
  {text: "Isn't pairing twice as expensive?", details: nil, topic_id: 7, user_id: nil, slug: "isn-t-pairing-twice-as-expensive", aasm_state: "verified", answers_count: 1},
  {text: "Isn't pairing just about catching typos?", details: nil, topic_id: 7, user_id: nil, slug: "isn-t-pairing-just-about-catching-typos", aasm_state: "verified", answers_count: 1},
  #9
  {text: "What is the point of this website?", details: nil, topic_id: 15, user_id: nil, slug: "what-is-the-point-of-this-website", aasm_state: "verified", answers_count: 1},
  {text: "Why does this website exist?", details: nil, topic_id: 15, user_id: nil, slug: "why-does-this-website-exist", aasm_state: "verified", answers_count: 1},
  #11
  {text: "Who created this website?", details: nil, topic_id: 15, user_id: nil, slug: "who-created-this-website", aasm_state: "verified", answers_count: 1},
  {text: "How does this website make money?", details: nil, topic_id: 15, user_id: nil, slug: "how-does-this-website-make-money", aasm_state: "verified", answers_count: 1},
  #13
  {text: "How can you ever expect to ask and answer every question possible?", details: nil, topic_id: 15, user_id: nil, slug: "how-can-you-ever-expect-to-ask-and-answer-every-question-possible", aasm_state: "verified", answers_count: 1},
  {text: "Why would I use this site?", details: nil, topic_id: 15, user_id: nil, slug: "why-would-i-use-this-site", aasm_state: "verified", answers_count: 1},
  #15
  {text: "What are different uses for this site?", details: nil, topic_id: 15, user_id: nil, slug: "what-are-different-uses-for-this-site", aasm_state: "verified", answers_count: 1},
  {text: "What are the rules?", details: nil, topic_id: 15, user_id: nil, slug: "what-are-the-rules", aasm_state: "verified", answers_count: 1},
  #17
  {text: "How is this website different from StackOverflow, Metafilter, Quora, etc?", details: nil, topic_id: 15, user_id: nil, slug: "how-is-this-website-different-from-stackoverflow-metafilter-quora-etc", aasm_state: "verified", answers_count: 1},
  {text: "Why wouldn't you pair program?", details: nil, topic_id: 7, user_id: nil, slug: "why-wouldn-t-you-pair-program", aasm_state: "verified", answers_count: 1},
  #19
  {text: "Why is pair programming valuable?", details: nil, topic_id: 7, user_id: nil, slug: "why-is-pair-programming-valuable", aasm_state: "verified", answers_count: 1},
  {text: "What is the current best practice for user authentication in RoR?", details: nil, topic_id: 4, user_id: nil, slug: "what-is-the-current-best-practice-for-user-authentication-in-ror", aasm_state: "verified", answers_count: 0},
  #21
  {text: "What is a state machine?", details: nil, topic_id: 11, user_id: nil, slug: "what-is-a-state-machine", aasm_state: "verified", answers_count: 1},
  {text: "Why would I use a state machine?", details: nil, topic_id: 11, user_id: nil, slug: "why-would-i-use-a-state-machine", aasm_state: "verified", answers_count: 1},
  #23
  {text: "What is the best state machine gem for Ruby on Rails?", details: nil, topic_id: 11, user_id: nil, slug: "what-is-the-best-state-machine-gem-for-ruby-on-rails", aasm_state: "verified", answers_count: 1},
  {text: "I'm getting the error \"NoMethodError: undefined method `aasm_state'\", what can I do?", details: nil, topic_id: 12, user_id: nil, slug: "i-m-getting-the-error-nomethoderror-undefined-method-aasm_state-what-can-i-do", aasm_state: "verified", answers_count: 1},
  #25
  {text: "A question!", details: nil, topic_id: 1, user_id: nil, slug: "a-question", aasm_state: "suspect", answers_count: 0},
  {text: "What are some good designs for tabs in a website?", details: nil, topic_id: 14, user_id: nil, slug: "what-are-some-good-designs-for-tabs-in-a-website", aasm_state: "unverified", answers_count: 1},
  #27
  {text: "How do you get coffeescript to load properly with turbolinks?", details: nil, topic_id: 3, user_id: nil, slug: "how-do-you-get-coffeescript-to-load-properly-with-turbolinks", aasm_state: "unverified", answers_count: 1},
  {text: "How do you get Redcarpet to display multiline code?", details: nil, topic_id: 10, user_id: nil, slug: "how-do-you-get-redcarpet-to-display-multiline-code", aasm_state: "unverified", answers_count: 1},
  #29
  {text: "Why is white space being added when I submit a form with a textarea in it?", details: nil, topic_id: 2, user_id: nil, slug: "why-is-white-space-being-added-when-i-submit-a-form-with-a-textarea-in-it", aasm_state: "unverified", answers_count: 1},
  {text: "How can I use assert_select to test for the presence of hidden content?", details: nil, topic_id: 2, user_id: nil, slug: "how-can-i-use-assert_select-to-test-for-the-presence-of-hidden-content", aasm_state: "unverified", answers_count: 1},
  #31
  {text: "How do you fix the error: \"role '[USERNAME]' does not exist\"?", details: "", topic_id: 6, user_id: nil, slug: "how-do-you-fix-the-error-role-role-does-not-exist", aasm_state: "unverified", answers_count: 1},
  {text: "How do you update a counter_cache after adding it via migration?", details: nil, topic_id: 2, user_id: nil, slug: "how-do-you-update-a-counter_cache-after-adding-it-via-migration", aasm_state: "unverified", answers_count: 1},
  #33
  {text: "What are some good strftime resources?", details: nil, topic_id: 1, user_id: nil, slug: "what-are-some-good-strftime-resources", aasm_state: "unverified", answers_count: 1},
  {text: "How do I pass arguments to a rake task?", details: nil, topic_id: 2, user_id: nil, slug: "how-do-i-pass-arguments-to-a-rake-task", aasm_state: "unverified", answers_count: 1},
  #35
  {text: "How can you do an http request from your rails application?", details: nil, topic_id: 2, user_id: nil, slug: "how-can-you-do-an-http-request-from-your-rails-application", aasm_state: "unverified", answers_count: 0},
  {text: "If it healthy to eat a high fat diet?", details: nil, topic_id: 16, user_id: nil, slug: "if-it-healthy-to-eat-a-high-fat-diet", aasm_state: "unverified", answers_count: 0}
])

Answer.create!([
  #1
    {text: "There are a lot of reasons you would do tdd:\n\n* Writing a test first provides immediate feedback when you write code. You can immediately see if the code you've written makes the test pass or not.\n* It immediately provides feedback about other areas of the code. When you run your tests you can immediately see if your code changes had any unintended consequences in other areas of the code base.\n* Writing tests first helps you structure your code in a more compartmentalized fashion, helping to avoid overloaded methods and side effects. In general it helps make your code more readable.\n* Your tests act as an active contract with your code. Someone new can look at the tests and better understand the range of inputs and outputs the code expects.\n* Writing tests first really helps to ensure your code is well-tested.\n\nNote: some of these reasons have more to testing in general than TDD specifically, but since TDD does tend to encourage more robust testing I included them here.\n", question_id: 1, user_id: nil},
    {text: "I would reference the answer here: [Why would you do TDD?](/1)\n", question_id: 2, user_id: nil},
    {text: "There are definitely some challenges associated with TDD.\n\n* Sometimes you aren't quite sure what you are building and you need to do a prototype before you feel comfortable approaching it from a test-first perspective. I'd certainly encourage this and then, once you have a better idea about what you are building then rewrite the existing code by writing tests first.\n* I often struggle with TDD simply because I am excited to see what ever I am building exist and so I deprioritize testing the functionality. This often derives from my sense that it will be faster if I don't write tests first, but very often this assumption proves wrong and it would have been faster to write a test first. The test would have provided a rapid feedback loop that would have hastened development time.\n* I've heard many people complain about having to change tests as functionality within the product changes. This certainly can be a hassle, but it is relatively easy to change a test while it can be essentially impossible to fully grasp the ramifications of a change within a large codebase without tests. I've rarely felt that burdened by the existence of tests.\n* Sometimes you are building something for which good testing frameworks do not yet exist. This makes it very difficult to TDD and I would say this may be a good reason to not TDD, but even then you would likely add a lot of value to the world if you built or contributed to a testing framework...\n", question_id: 3, user_id: nil},
    {text: "You can approach pairing in many different ways (one screen/one keyboard/one mouse, two of each, remote pairing, etc). Ideally you try to create a comfortable environment that facilitates effective communication between the two people. In the past I've found that atleast two keyboards and two mice are valuable and that two screens can help ergonomically.\n\nPairing remotely can be a bit challenging, but if you can get a high-quality connection I think it is very feasible and you can even forget that you are pairing remotely. There is some benefit to being able to read your pair's body language, but I've never seen that aspect distract a pair too much.\n", question_id: 4, user_id: nil},
    {text: "You can, but I'd recommend using two keyboards and two mice. More here: [How do you technically do pairing?](/questions/4)\n", question_id: 5, user_id: nil},
  #6
    {text: "Really any setup that is comfortable and facilitates effective communication between the pair is ideal. Some more thoughts here: [How do you technically do pairing?](/questions/how-do-you-technically-do-pairing)\n", question_id: 6, user_id: nil},
    {text: "This is a common question. There is clearly a cost associated with having two people work on the same code at the same time, but this cost is offset (and I believe results in savings overall) due to the following observations:\r\n            \r\n* Collaboration: Software development is complicated. Having someone to discuss the design and implementation of a feature can greatly improve the design and reduce the likelihood of errors. In many companies code reviews are used to bridge this gap, but with pairing there is more opportunity for back and forth during development, further improving code quality.\r\n* Micro-Breaks: Software development is mentally taxing. I personally can't code for 8 hours straight without taking breaks. I frequently get distracted by various websites when I'm wrestling with a design decision and may get sucked into an article, emerging 15 minutes later to return to the work. With a pair you can take micro-breaks, allowing your pair to take the driver's seat while you observe. This gives you a chance to rest a bit without taking an extended break. In general you're much more likely to put in a maximum effort while pairing then while soloing (maybe some people are exceptions to this, but I think organizationally speaking this will hold true).\r\n* Information Transfer: When two people pair program they both become intimately familiar with the code they are designing. This helps to spread information and best practices around the organization and reduces bottlenecks and the possibility of problems when a key employee leaves the organization. When building complex software the added communication that pair programming provides can be invaluable to ensuring everyone on the team is on the same page and the team is resilient as it evolves.\r\n* Error Checking: People do make mistakes when writing code. Having a pair can help ensure that, when you do make a mistake, it is caught quickly and is less likely to waste time. It is not the only reason why pairing is valuable, but it is a valid reason.\r\n* Learning: This is kind of the same as \"Information Transfer\" but I think is worth highlighting. I think Pair Programming is one of the best ways to learn. You're collaboratively working with someone else on a common challenge so you'll be exposed to new ideas and techniques within a context that you are intimately familiar with. It is one of the better ways of learning something that I have experienced.\r\n            \r\nIn general I've found that these reasons add up to a process that is definitively not 2x more expensive. I personally believe that it may be more cost-effective to pair program, but it is difficult, if not impossible, to prove that.\r\n            ", question_id: 7, user_id: nil},
    {text: "No, that is a valid benefit of pair programming but there are other, more valuable benefits. More details on those benefits can be found here: [Isn't pairing twice as expensive?](/questions/isn-t-pairing-twice-as-expensive)\n", question_id: 8, user_id: nil},
    {text: "InfiniteQ was created to try and make it easy for people to ask questions and get answers about anything. It was originally conceived because [Jared Cosulich](http://about.me/jaredcosulich) was developing [The Puzzle School](http://www.puzzleschool.com) and noticed how that being able to ask questions and find answers quickly was a great way to approach learning any subject. \r\n\r\nIt has since evolved beyond just learning about educational topics. It can be used to create a more dynamic FAQ or support section for a company. It can be used to interview politicians or by cities to provide information about services and how to use them.\r\n\r\nInfiniteQ also provides an opportunity to ask questions about [Wikipedia](htttp://www.wikipedia.com) topics. With many topics there is some debate as to what is the truth and InfiniteQ allows for more exploration of those debates than Wikipedia does with its single page per topic. Both sources of information are valuable. InfiniteQ is complementary to Wikipedia in this way.", question_id: 9, user_id: nil},
    {text: "InfiniteQ is really an experiment at helping people learn about and debate topics. You can read more about why it got started here: [What is the point of this website?](/questions/what-is-the-point-of-this-website)", question_id: 10, user_id: nil},
  #11
    {text: "[Jared Cosulich](http://www.about.me/jaredcosulich) created it as part of a larger effort to create [The Puzzle School](http://www.puzzleschool.com) although InfiniteQ has become useful beyond The Puzzle School as well.", question_id: 11, user_id: nil},
    {text: "Right now it does not make money, but it may display advertising or charge companies for private, white-labeled InfiniteQ integrations in the future. It's also possible that it will start a job board as other Q&A sites have had some success with that strategy.", question_id: 12, user_id: nil},
    {text: "I don't think you can, but we figured that every question that got asked and answered would make that information just a bit more accessible for the next person trying to find it. That alone seemed to justify trying.", question_id: 13, user_id: nil},
    {text: "There are a number of reasons you might create a topic on this site:\r\n\r\n* You are a teacher and want to create a resource your students can easily access and build on if they have questions about a topic.\r\n* You want to create a FAQ about a company or service.\r\n* You are hosting an event and want an easy way for people to ask you questions regarding the event.\r\n* You are a politician and want to make it easy for voters to ask you questions.\r\n* You are an expert in some area and would like to share your expertise with the world.\r\n* You are a beginner and need help with something.\r\n* I'm sure there are other use cases, but that's a good start.", question_id: 14, user_id: nil},
    {text: "I did a brainstorm of possible uses here: [Why would I use this site?](/questions/why-would-i-use-this-site)", question_id: 15, user_id: nil},
  #16
    {text: "You can see the rules of the site on the right sidebar, but just to reiterate:\r\n\r\n* Every possible question is valued, even closely related questions. (including different wording)\r\n* You can write an answer to your own question. This is valued as well.\r\n* No question should ever be dismissed if a similar question has already been answered. You can provide a link to the existing question, but never suggest that the question should not have been asked. All questions are valued.\r\n* Personal attacks are not welcome and will be removed immediately.", question_id: 16, user_id: nil},
    {text: "We created this website with one primary goal (that we didn't see represented in other Q&A sites):\r\n                        \r\n* We wanted to encourage people to ask as many questions as possible and even answer their own questions. The goal was not just to help people who have a question, but to map out the world's knowledge via questions.\r\n\r\nThis goal led to a number of decisions, including making it as easy as possible for someone to ask and answer questions if they don't yet have an account. In order to improve the quality of questions and answers we've designed a number of verification stages, so if you submit a question without providing an email then your question will be accessible on the website, but will be hidden from search crawlers and will be categorized as \"unverified\" until someone verifies that it is a valid question and not just spam.\r\n                        \r\nI don't know of all of the possible Q&A sites that exist, so it's possible there is something very similar out there. Either way we felt that this difference justified building a new website.\r\n                        \r\nAs a software engineer I've never been disappointed by the proliferation of Q&A sources on the Internet. If I have a question then having a multitude of answers to explore has always felt beneficial. I don't think there's really any downside to having another Q&A site...", question_id: 17, user_id: nil},
    {text: "Pair programming takes two people. It is significantly harder to coordinate two people working together than to just sit down and program by yourself. Within an organization where people have meetings at different times it can be difficult to coordinate consistent time to pair program.\r\n\r\nPair programing also requires a lot of talking. It is a highly collaborative process and some people will find the level of required discussion to be exhausting.\r\n\r\nI also think people may feel like they are being constantly evaluated while pair programming. There is certainly an element of this, but I have seen many pair programming environments where people feel supported and learn a lot while pairing instead of feeling judged.", question_id: 18, user_id: nil},
    {text: "I provided some thoughts on this here: [Isn't pairing twice as expensive?](/questions/isn-t-pairing-twice-as-expensive)", question_id: 19, user_id: nil},

  #21
    {text: "The wikipedia definition of a [Finite-state Machine](https://en.wikipedia.org/wiki/Finite-state_machine) covers this comprehensively. Here is an attempt at a simple explanation:\r\n\r\nA state machine, or more precisely a finite-state machine, is a way to organize the behavior of an object based on it's state. For example a light could be \"on\" or \"off\" or a person could be \"laying down\", \"sitting\", \"standing up\", \"walking\", or \"running\".\r\n\r\nIn each state the object behaves differently and certain events will transition the object from one state to another. Also the object can only be in one state at a time.", question_id: 21, user_id: nil},
    {text: "This blog post provides some good thoughts on this question: [Why Developers Never Use State Machines](http://www.skorks.com/2011/09/why-developers-never-use-state-machines/). ", question_id: 22, user_id: nil},
    {text: "The [Ruby Toolbox](https://www.ruby-toolbox.com/categories/state_machines.html) suggests that the [state_machine gem](https://github.com/pluginaweek/state_machine) is best. This blog [The State of State Machines](http://blog.bitcrowd.net/2015/01/08/the-state-of-state-machines/), though, suggests that the state_machine gem may be out of date, and Github does show that the project was last updated in May of 2013.\r\n\r\nFor this reason I'm going with the second option from Ruby Toolbox that the blog post also recommends: [Acts As State Machine (AASM)](https://github.com/aasm/aasm).", question_id: 23, user_id: nil},
    {text: "You need to generate the aasm_state column on each ActiveRecord you want use the AASM gem. If you run:\r\n\r\n`rails generate aasm [MODEL NAME]`\r\n\r\nIt will add the column to the model and add the necessary code to the model to get started setting up the states.", question_id: 24, user_id: nil},

  #26
    {text: "Here is a pinterest board: [https://www.pinterest.com/antonkazakov712/tabs-in-ui/](https://www.pinterest.com/antonkazakov712/tabs-in-ui/)\r\n\r\nHere are a few of my favorites: [Option 1](https://s-media-cache-ak0.pinimg.com/736x/63/a5/dc/63a5dc2212e2ea275aa1db0cf6771f2a.jpg) [Option 2](https://www.smashingmagazine.com/wp-content/uploads/images/module-tabs/atebits.jpg) [Option 3] (https://material-design.storage.googleapis.com/publish/material_v_8/material_ext_publish/0B6Okdz75tqQsOGUyd0ZGSWhwdkE/components_tabs_usage_desktop7.png) [Option 4] (http://ui-patterns.com/uploads/image/file/9/best_old_182.jpg) [Option 5] (https://www.smashingmagazine.com/wp-content/uploads/images/module-tabs/vyniknite.gif) [Option 6](https://www.smashingmagazine.com/wp-content/uploads/images/module-tabs/mint.gif) [Option 7](http://webdesignledger.com/wp-content/uploads/2015/04/08-semantic-ui-tabs-design.jpg)", question_id: 26, user_id: nil},
    {text: "There is a pretty good response to this here: [Rails 4: how to use $(document).ready() with turbo-links](http://stackoverflow.com/questions/18770517/rails-4-how-to-use-document-ready-with-turbo-links) \r\n                                                \r\nBasic code is:\r\n\r\n```coffeescript\r\nready = ->\r\n                                                \r\n...your coffeescript goes here...\r\n                                                \r\n$(document).ready(ready)\r\n$(document).on('page:load', ready)\r\n```", question_id: 27, user_id: nil},
    {text: "If you use the redcarpet gem then this setup will allow you to use three ` (backtick) or ~ to create a codeblock:\r\n                                    \r\n```\r\n  def markdown(text)\r\n    options = {\r\n      filter_html:     true,\r\n      hard_wrap:       true,\r\n      link_attributes: { rel: 'nofollow', target: \"_blank\" },\r\n      space_after_headers: true\r\n    }\r\n\r\n    extensions = {\r\n      autolink:           true,\r\n      superscript:        true,\r\n      disable_indented_code_blocks: true,\r\n      fenced_code_blocks: true\r\n    }\r\n\r\n    renderer = Redcarpet::Render::HTML.new(options)\r\n    markdown = Redcarpet::Markdown.new(renderer, extensions)\r\n\r\n    markdown.render(text).html_safe\r\n  end\r\n```\r\n                                    \r\nSpecifically the `fenced_code_blocks: true` in the extensions variable (not in the renderer variable) enables this.", question_id: 28, user_id: nil},
    {text: "The problem may be due to haml. There are a number of resources dealing with this issue here:\r\n\r\nhttp://stackoverflow.com/questions/2623166/rails-whitespace-added-to-content-of-textarea-on-save\r\nhttps://github.com/haml/haml/issues/643\r\n\r\nbut the best resource (the one that led to my successful resolution was this one:\r\n\r\nhttp://stackoverflow.com/questions/35428363/excess-spaces-wile-rendering-multiline-string-in-rails-5\r\n\r\nThe fix that worked for me on Rails 5 and Haml 4.0.7 was to create a haml.rb initializer and add this line:\r\n\r\n`Haml::Template.options[:ugly] = true`", question_id: 29, user_id: nil},
    {text: "assert_select should pick up any element on the page unless you are running it through a headless browser.", question_id: 30, user_id: nil},
  #31
    {text: "There is a good answer to this here [PostgreSQL error: Fatal: role “username” does not exist](http://stackoverflow.com/questions/11919391/postgresql-error-fatal-role-username-does-not-exist).\r\n\r\nSpecifically this code worked:\r\n\r\n```\r\npostgres=# CREATE ROLE [USERNAME] superuser;\r\nCREATE ROLE\r\n\r\npostgres=# ALTER ROLE [USERNAME] WITH LOGIN;\r\nALTER ROLE\r\n```", question_id: 31, user_id: nil},
    {text: "If your model is a Post and you are updating the counter for comments you'd run the following:\r\n\r\n``` ruby\r\nPost.find_each { |post| Post.reset_counters(post.id, :comments) }\r\n```", question_id: 32, user_id: nil},
    {text: "I've found [Strftime.net](http://strftime.net/) to be useful. [For a Good Strftime](http://www.foragoodstrftime.com/) has some great examples as well.", question_id: 33, user_id: nil},
    {text: "There is a great answer here: [How do I pass command line arguments to a rake task?](http://stackoverflow.com/questions/825748/how-do-i-pass-command-line-arguments-to-a-rake-task).\r\n\r\nHere's the basic code:\r\n\r\n``` ruby\r\nrequire 'rake'\r\n\r\ntask :my_task, [:arg1, :arg2] do |t, args|\r\n  puts \"Args were: \#{args}\"\r\nend\r\n```\r\n\r\nFrom the command line:\r\n\r\n``` ruby\r\n> rake my_task[1,2]\r\nArgs were: {:arg1=>\"1\", :arg2=>\"2\"}\r\n```", question_id: 34, user_id: nil}
])
