class RegistrationMailer < ActionMailer::Base
  default from: "from@example.com"

  def confirmation(registration)
    @registration = registration
    mail :to => @registration.email,
      :subject => "Confirmation de votre inscription sur hp99.fr"
  end
end
