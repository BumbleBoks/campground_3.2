class UsersController < ApplicationController
  before_filter :guest_user, :only => [:new, :create]
  before_filter :authorize_user, :only => [:show, :edit, :update]
  before_filter :account_owner, :only => [:edit, :update]
  
  def show
    @user = User.find_by_id(params[:id])
  end

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      log_in @user
      redirect_to root_path
    else
      render 'new'
    end
  end

  def edit
    @user = User.find_by_id(params[:id])
  end

  def update
    if @user.update_attributes(params[:user])
      redirect_to @user
    else
      render 'edit'
    end
  end

  private
  def account_owner
    @user = User.find_by_id(params[:id])
    unless current_user?(@user)
      redirect_to root_path
      false
    end
  end

end
