class FollowingMailer < ApplicationMailer
  include ActionView::Helpers::TextHelper

  def object_created(object, following)
    return if object.user == following.user
    @object = object
    @following = following
    subject = "InfiniteQ: #{object.class.to_s} added to #{following.object.class.to_s.downcase}: "
    @title = following.object.try(:title)
    @title = following.object.text if @title.blank?
    subject += truncate(@title, length: 20)
    mail(subject: subject, to: "#{following.user.name} <#{following.user.email}>")
  end

end
