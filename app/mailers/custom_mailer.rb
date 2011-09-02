class CustomMailer < ActionMailer::Base
  default from: "paul@hp99.fr"

  def custom(registration, subject, body)
    @message = body
    mail :to => registration.email,
      :subject => subject
  end
end
