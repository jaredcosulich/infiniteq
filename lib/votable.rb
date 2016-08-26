module Votable

  def update_votes
    total_trust = self.public_send("#{self.class.to_s.downcase}_votes").sum(:trust)
    total_trust += user.trust if user.present?

    update_column :vote_total, total_trust
  end

  def transition_states
    verify! if vote_total >= 10 and !verified?
    unverify! if vote_total < 10 and !unverified?
  end

end
