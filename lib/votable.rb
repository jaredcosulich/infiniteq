module Votable
  def update_votes
    total_trust = self.public_send("#{self.class.to_s.downcase}_votes").sum(:trust)
    total_trust += user.trust if user.present?
    update_column :vote_total, total_trust
  end
end
