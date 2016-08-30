namespace :migrations do
  desc "update trust to be 10x what it was before"
  task update_trust: :environment do
    User.all.each  { |u| u.update(trust: u.trust * 10)}
    Question.all.each { |q| q.update(vote_total: q.vote_total * 10) }
    Answer.all.each { |a| a.update(vote_total: a.vote_total * 10) }
    QuestionVote.all.each  { |qv| qv.update(trust: qv.trust * 10)}
    AnswerVote.all.each  { |av| av.update(trust: av.trust * 10)}
  end

end
