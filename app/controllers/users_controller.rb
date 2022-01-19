class UsersController < ApplicationController
    before_action :authenticate_user!
  def show
    @user ||= current_user
  end

  def update
    user = current_user
    user.name = username_params[:name].strip if username_params[:name].nil? == false
    if user.update(password_params)
      redirect_to user_path(current_user)
    else
      render action: "show"
    end
  end

  def destroy
    @user = current_user
    @user.destroy
    redirect_to root_path
  end

  private

  def username_params
    params.require(:user).permit(:name)
  end

  def password_params
    params.require(:user).permit(:password, :password_confirmation, :reset_password_token)
  end
end
