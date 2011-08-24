class RegistrationsController < ApplicationController
  def show
    @registration = Registration.find params[:id]
    respond_with @registration
  end

  def new
    @registration = Registration.new
    respond_with @registration
  end

  def create
    @registration = Registration.new params[:registration]
    flash[:notice] = "thx" if @registration.save
    respond_with @registration
  end
end
