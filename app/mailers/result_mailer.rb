class ResultMailer < ActionMailer::Base
  default from: "paul@hp99.fr"

  def avert(registration, result)
    @registration = registration
    @result = result
    mail :to => @registration.email,
      :subject => "HP Touchpad sur le dite de #{@result.service.full_name}"
    @registration.received_by_email_results << @result
  end
end
