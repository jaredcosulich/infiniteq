class FlagMailer < ApplicationMailer
  include ActionView::Helpers::TextHelper

  def flag_created(flag)
    @flag = flag
    @object = @flag.object
    subject = "InfiniteQ: Your #{@object.class.to_s.downcase} was flagged."
    mail(subject: subject, to: "#{@object.user.name} <#{@object.user.email}>")
  end

end
