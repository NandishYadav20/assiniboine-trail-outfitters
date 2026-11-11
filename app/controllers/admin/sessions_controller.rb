class Admin::SessionsController < ApplicationController
  def new; end

  def create
    user = AdminUser.find_by(email: params[:email].to_s.downcase.strip)
    if user&.authenticate(params[:password].to_s)
      session[:admin_user_id] = user.id
      redirect_to admin_products_path, notice: "Welcome back."
    else
      flash.now[:alert] = "Invalid email or password."
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session.delete(:admin_user_id)
    redirect_to root_path, notice: "You have logged out."
  end
end
