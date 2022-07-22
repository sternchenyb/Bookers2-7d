class BooksController < ApplicationController

   #before_action :correct_user, only: [:edit, :update]

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
   if @book.save
     flash[:notice] = "You have created book successfully."
    redirect_to book_path(@book)
   else
    @books = Book.all
    @user = current_user
    render :index
   end
  end

  def index
    @book = Book.new
    @books = Book.all
    @user = current_user
  end

  def show
    @book = Book.find(params[:id])
    @book_new = Book.new
    @user = current_user
  end

  def edit
    @book = Book.find(params[:id])
    @book.user_id = current_user.id
  end
  
  def update
   @book = Book.find(params[:id])
   @book.user_id = current_user.id
   if @book.update(book_params)
     flash[:notice] = "You have updated book successfully."
    redirect_to book_path(@book)
   else
    render :edit
   end
  end
  
  def destroy
   book = Book.find(params[:id])
   book.destroy
   redirect_to books_path
  end
  
  private
  
  def book_params
    params.require(:book).permit(:title, :body)
  end
  
  def correct_user
     @book = Book.find(params[:id])
     @user = @book.user
       redirect_to(books_path) 
       unless @user == current_user
       end
  end
end