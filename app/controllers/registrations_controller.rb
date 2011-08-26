class RegistrationsController < ApplicationController
  def show
    @registration = Registration.find params[:id]
    respond_with @registration
  end

  def new
    @registration = Registration.new
    @last_results = Result.order_by([[:created_at, :desc]]).limit(5)
    respond_with @registration
  end

  def create
    @registration = Registration.new params[:registration]
    flash[:notice] = "thx" if @registration.save
    respond_with @registration
  end

  def confirmation
    @registration = Registration.find params[:id]
    if @registration.confirmation_token == params[:confirmation_token]
      @registration.confirm!
      flash[:notice] = "merci"
    end
    redirect_to registration_path(@registration)
  end
end
