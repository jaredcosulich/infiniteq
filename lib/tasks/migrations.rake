namespace :migrations do
  desc "update trust to be 10x what it was before"
  task update_trust: :environment do
    User.all.each  { |u| u.update(trust: u.trust * 10)}
    Question.all.each { |q| q.update(vote_total: q.vote_total * 10) }
    Answer.all.each { |a| a.update(vote_total: a.vote_total * 10) }
    QuestionVote.all.each  { |qv| qv.update(trust: qv.trust * 10)}
    AnswerVote.all.each  { |av| av.update(trust: av.trust * 10)}
  end

  task create_trust_events: :environment do
    [
      Question.all.unscoped,
      Answer.all.unscoped,
      QuestionVote.all.unscoped,
      AnswerVote.all.unscoped
    ].flatten.sort { |a,b| a.created_at <=> b.created_at }.each do |object|
      event = object.send(:create_trust_event)
      event.update(created_at: object.created_at)
    end
  end

end
