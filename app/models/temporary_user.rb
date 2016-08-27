class TemporaryUser < ApplicationRecord

  def voted_on?(object, positive)
    object_type = object.class.to_s.downcase
    return positive == true if (public_send("parsed_#{object_type}s") || {})[object.id.to_s].present?
    vote_id = parsed_votes[object_type][object.id.to_s]
    return false if vote_id.nil?
    vote = object.public_send("#{object_type}_votes").find(vote_id)
    positive == vote.try(:trust) > 0
  end

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

  def parsed_questions
    JSON.parse(questions || {}.to_json)
  end

  def add_question(question)
    pq = parsed_questions
    pq[question.id.to_s] = true
    update(questions: pq.to_json)
  end

  def parsed_answers
    JSON.parse(answers || {}.to_json)
  end

  def add_answer(answer)
    pa = parsed_answers
    pa[answer.id.to_s] = true
    update(answers: pa.to_json)
  end

end
