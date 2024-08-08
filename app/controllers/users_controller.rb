class UsersController < ApplicationController
  before_action :require_user, except: [:new, :create]

  def new
    puts "in new"
    if session[:user_id]
      redirect_to '/' if User.find(session[:user_id])
    else
      puts "in new else "
      # @user = User.new
    end
  end

  def create
    @user = User.new(user_params)
    puts user_params
    puts "before save"
    if @user.save
      puts "after save"
      session[:user_id] = @user.id
      redirect_to '/'
      else
        render :'users/new'
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    @profile_updated = false
    if @user.update(user_params)
      @profile_updated = true
      render root_path
    else
      render :edit
    end
  end

  private

  def user_params
    params.permit(:user_name, :full_name, :email, :password)
  end
end