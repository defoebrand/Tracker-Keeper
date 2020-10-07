class UsersController < ApplicationController
  before_action :check_user_log_in, except: %i[splash new create]

  def splash
    redirect_to user_path(session[:user_id]) if session[:user_id]
  end

  def index
    redirect_to root_path unless session[:user_id] == 4
    @users = User.with_attached_avatar.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        session[:user_id] = @user.id
        format.html { redirect_to user_path(@user.id), notice: 'User was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :avatar)
  end
end
