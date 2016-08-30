class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :omniauthable

  has_many :questions
  has_many :answers
  has_many :question_votes
  has_many :answer_votes
  has_many :trust_events

  before_save :update_trust

  def voted_on?(object, positive)
    object_type = object.class.to_s.downcase
    return positive == true if public_send("#{object_type}s").where(id: object.id).present?
    vote = public_send("#{object_type}_votes").find_by("#{object_type}_id" => object.id)
    vote.present? ? (positive == vote.trust > 0) : false
  end


  private

    def update_trust
      self.trust = self.trust_events.sum(:trust) + (confirmed? ? 100 : 10)
    end



end
