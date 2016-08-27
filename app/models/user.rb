class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :omniauthable

  has_many :question_votes
  has_many :answer_votes

  before_save :update_trust

  def voted_on?(object, positive)
    object_type = object.class.to_s.downcase
    vote = public_send("#{object_type}_votes").find_by("#{object_type}_id" => object.id)
    return false if vote.blank?
    positive == vote.trust > 0
  end


  private

    def update_trust
      self.trust = 10 if confirmed?
    end



end
