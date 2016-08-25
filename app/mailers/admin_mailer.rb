class AdminMailer < ApplicationMailer

  default to: 'jared@irrationaldesign.com', from: 'services@infiniteq.net'

  def object_created(object_created)
    @object_created = object_created
    mail(subject: "InfiniteQ #{object_created.class.to_s} Created")
  end

end
