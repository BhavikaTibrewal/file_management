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
    # else
    #   render :'users/new'
    end
  end
  def edit

  end

  def update

  end

  def show
    @profile_updated = false
  end

  private
  def user_params
    params.require(:user).permit(:user_name, :full_name, :email, :password)
  end
end