class Admin::MailerController < Admin::AdminController
  def send_email
    if params[:subject].present? && params[:body].present?
      Registration.confirmed.each do |registration|
        CustomMailer.custom(registration, params[:subject], params[:body]).deliver
      end
      flash[:notice] = "Successful send"
      redirect_to admin_send_email_path
    end
  end
end