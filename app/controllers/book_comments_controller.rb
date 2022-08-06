class BookCommentsController < ApplicationController
  before_action :authenticate_user! 
  before_action :correct_user, only: [:destroy]
  
  def create
     @book = Book.find(params[:book_id])
     @book_comment = current_user.book_comments.new(book_comment_params)
     @book_comment.book_id = @book.id
     @book_comment.save
  end
  
  def destroy
     @book = Book.find(params[:book_id])
     @book_comment = BookComment.find(params[:id])
     @book_comment.destroy
  end

private

 def book_comment_params
   params.require(:book_comment).permit(:comment)
 end
 
 def correct_user
    book_comment = BookComment.find(params[:id])
    if current_user.id != book_comment.user.id
        redirect_to books_path
    end
 end
end