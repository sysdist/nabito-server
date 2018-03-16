class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :user_approved


  def index
    return unless user_admin
    @users = User.all
  end

  def show
    set_user
    if @user != current_user && !current_user.is_admin
      redirect_to root_path, :alert => "Access denied."
    end
  end
  
  def menu
    set_user
  end
  
  def approve
    return unless user_admin   
    set_user
    @user.approve
    redirect_to users_path
  end
  
  def disapprove
    return unless user_admin
    set_user
    @user.disapprove
    redirect_to users_path
  end
  
  def destroy
    set_user
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  private
  
    def set_user
      @user = User.find(params[:id])
    end


end
