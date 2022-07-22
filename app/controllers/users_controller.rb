class UsersController < ApplicationController

    before_action :correct_user, only: [:edit, :update]
    
   def new
     @user = User.new
   end

  def show
    @user = User.find(params[:id])
    @books = Book.all
    @book = Book.new
  end
  
  def create
    @user = User.new(user_params)
    @user.user_id = current_user.id
    if @user.save
      flash[:notice] = "Welcome! You have signed up successfully."
     redirect_to user_path(@user)
    else
     render :books
    end
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(@user)
    else
      render :edit
    end
  end
  
  def edit
    @user = User.find(params[:id])
    @user = current_user
  end
  
  def index
    @users = User.all
    @user = current_user
    @book = Book.new
  end
  
  def destroy
   @user = User.find(params[:id])
   @user.destroy(user_params)
   flash[:notice] = "Signed out successfully."
     redirect_to root_path
  end
  
  
  
  private
  
  def user_params
    params.require(:user).permit(:name,:introduction,:profile_image,)
  end
  
  def correct_user
    @user = User.find(params[:id])
      if current_user!= @user
       redirect_to user_path(@user)
      end
  end
end
