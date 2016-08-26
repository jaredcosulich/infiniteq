class TemporaryUser < ApplicationRecord

  def self.add_object(object, remote_ip)
    temporary_user = TemporaryUser.find_or_create_by(ip_address: remote_ip)
    if object.class.to_s =~ /Vote/
      temporary_user.add_vote(object)
    else
      temporary_user.add_question(object)
    end
  end

  def parsed_votes
    JSON.parse(votes || {'question' => {}, 'answer' => {}}.to_json)
  end

  def add_vote(vote)
    pv = parsed_votes
    topic = vote.topic.downcase
    topic_id = vote.topic_id.to_s
    existing_vote_id = pv[topic][topic_id]
    if (existing_vote = vote.class.find_by(id: existing_vote_id)).present?
      existing_vote.update(trust: vote.trust)
      vote.destroy
    else
      pv[topic][topic_id] = vote.id
      update(votes: pv.to_json)
    end
  end

  def add_question(question)
    parsed_questions = JSON.parse(questions || {}.to_json)
    parsed_questions[question.id] = true
  end

end
