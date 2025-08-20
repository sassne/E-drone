class Admin::UsersController < ApplicationController
  layout 'admin'
  before_action :set_user, only: [ :show, :edit, :update, :destroy ]

  def index
    authorize User
    @users = User.all
  end

  def new
    authorize User
    @user = User.new
  end

  def create
    authorize User
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path, notice: "Utilisateur créé avec succès."
    else
      render :new
    end
  end

  def edit
    authorize @user
  end

  def update
    authorize @user
    if @user.update(user_params)
      redirect_to admin_users_path, notice: "Utilisateur mis à jour."
    else
      render :edit
    end
  end

  def destroy
    authorize @user
    @user.destroy
    redirect_to admin_users_path, notice: "Utilisateur supprimé."
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, roles: [])
    end
end
