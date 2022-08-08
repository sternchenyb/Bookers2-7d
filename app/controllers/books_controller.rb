class BooksController < ApplicationController

  before_action :correct_user, only: [:edit,:destroy]
  
  def correct_user
    book = Book.find(params[:id])
    if current_user.id != book.user_id
      redirect_to books_path
    end
  end
  
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
    @book_new = Book.new
    @books = Book.all
    @user = current_user
  end

  def show
    @book = Book.find(params[:id])
    @book_new = Book.new
    @user = @book.user
    @book_comment = BookComment.new
    @book_comments = BookComment.all
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user_id = current_user.id
        render "edit"
    else
        redirect_to books_path
    end
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
   @book = Book.find(params[:id])
   if @book.destroy
     flash[:notice] = "Book have deleted successfully."
    redirect_to books_path
   end
  end
  
  private
  
  def book_params
    params.require(:book).permit(:title, :body, :star)
  end
  
end