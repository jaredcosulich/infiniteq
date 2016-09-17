class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :omniauthable

  has_many :topics
  has_many :questions
  has_many :answers
  has_many :question_votes
  has_many :answer_votes
  has_many :trust_events
  has_many :flags
  has_many :followings
  accepts_nested_attributes_for :followings

  before_save :update_trust
  after_save :consume_temporary_user_based_on_ip, if: Proc.new { |u| u.ip_address.present? }

  scope :today, -> { where('created_at > ?', 1.day.ago) }
  scope :this_week, -> { where('created_at > ?', 7.days.ago) }

  attr_accessor :ip_address
  attr_accessor :following

  MAX_TRUST_POTENTIAL = 10

  # include AASM
  # aasm do
  #   state :new, :initial => true
  #   state :assistant_editor
  #   state :editor
  #   state :admin
  #   state :super_admin
  #
  #   event :verify do
  #     transitions :from => [:unverified, :suspect], :to => :verified
  #   end
  # end

  def trust_potential
    (1..[((trust || 0) / 100).round, MAX_TRUST_POTENTIAL].min).to_a
  end

  def voted_on?(object, positive)
    object_type = object.class.to_s.downcase
    return positive == true if public_send("#{object_type}s").where(id: object.id).present?
    vote = public_send("#{object_type}_votes").find_by("#{object_type}_id" => object.id)
    vote.present? ? (positive == vote.trust > 0) : false
  end

  def has_flagged?(object)
    flags.find_by((object.is_a?(Question) ? 'question_id' : 'answer_id') => object.id).present?
  end

  def consume_temporary_user(temporary_user)
    return if temporary_user.nil?
    temporary_user.parsed_questions.keys.each do |question_id|
      question = Question.find(question_id)
      question.update(user: self)
      followings.create(question: question)
    end

    temporary_user.parsed_answers.keys.each { |answer_id| Answer.find(answer_id).update(user: self) }
    temporary_user.parsed_votes.each do |type, votes|
      votes.each do |vote_id|
        type.capitalize.constantize.find_by_id(vote_id).update(user: self)
      end
    end
    temporary_user.destroy
  end

  private

    def update_trust
      self.trust = self.trust_events.sum(:trust) + (confirmed? ? 100 : 10)
    end

    def consume_temporary_user_based_on_ip
      consume_temporary_user(TemporaryUser.where(ip_address: ip_address).first)
    end

end
