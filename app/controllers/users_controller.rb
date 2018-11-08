class UsersController < ApplicationController
  before_action :set_user, only: [:update, :destroy]
  before_action :set_user, only: [:update, :destroy]
  load_and_authorize_resource

  def index
    @users = User.order(:username)
  end

  def update
    if (@user.admin_role?) && (User.where(admin_role: true).count <= 1) && (user_params[:admin_role] == "0")
      flash[:alert] = 'Невозможно удалить последнего администратора'
    else
      @user.update(user_params) ? flash[:notice] = "Позьзователь #{@user.username} был успешно отредактрован" : flash[:alert] = 'Невозможно отредактирвовать пользователя'
    end
    redirect_to users_path
  end

  def destroy
    if (@user.admin_role?) && (User.where(admin_role: true).count <= 1)
      flash[:alert] = 'Невозможно удалить последнего администратора'
    else
      @user.destroy ? flash[:notice] = 'Пользователь был успешно удален' : flash[:alert] = 'Невозможно удалить этого пользователя'
    end
    redirect_to users_path
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:admin_role, :manager_role, :client_role, :username, :email)
  end
end
