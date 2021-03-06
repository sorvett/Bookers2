class BooksController < ApplicationController
	before_action :authenticate_user!
	def index
	@books = Book.all
	@book = Book.new
	@user =current_user
	end
	
	def new
		@book = Book.new
		if @book.save
       redirect_to book_path(@book.id) ,notice: 'Book was successfully created.'
    else
    	@books = Book.all
    	render 'index'
	end
	end
	
	def create
	@user =current_user
	@books = Book.all
	@book = Book.new(book_params)
	@book.user_id = current_user.id
    	if @book.save
       redirect_to book_path(@book.id) ,notice: 'Book was successfully created.'
    	else
    		render :index

		end
	end
	
	def show
	@book = Book.find(params[:id])
	@user = User.find(@book.user_id)
	@books = @book.book_comments
	@comment = BookComment.new
	end
	
	def edit
	@book = Book.find(params[:id])
	if current_user!= @book.user
		redirect_to books_path
	end
	end
	
	def update
  	 @book = Book.find(params[:id])
    if @book.update(book_params)
    redirect_to book_path(@book) ,notice: 'Book was successfully updated.'
	else
 	render 'edit'
	end
	end
	
	def destroy
	@book = Book.find(params[:id])
  	@book.destroy
  	if current_user!= @book.user
  	redirect_to books_path
  	end
	end

	private
    def book_params
        params.require(:book).permit(:title, :body)
    end
end
