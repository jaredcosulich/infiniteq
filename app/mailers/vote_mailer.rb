class VoteMailer < ApplicationMailer
  include ActionView::Helpers::TextHelper

  def vote_created(vote)
    @vote = vote
    @object = vote.topic == 'Answer' ? vote.answer : vote.question
    subject = "InfiniteQ: Your #{vote.topic.downcase} was voted #{vote.trust > 0 ? 'up' : 'down'}"
    mail(subject: subject, to: "#{@object.user.name} <#{@object.user.email}>")
  end

end
