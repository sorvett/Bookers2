class UsersController < ApplicationController
	before_action :authenticate_user!
	def index
		@user =current_user
		@book =Book.new
		@users = User.all
		@books = Book.all
	end
	
	def new
		@book = Book.new(books_params)
    if @book.save
       redirect_to book_path(@book.id) ,notice: 'Book was successfully created.'
    else
    	@books = Book.all
    	render 'show'
	end

	end
	def show
		@user = User.find(params[:id])
		@book = Book.new
		@books = @user.books
	end
	
	def edit
		@user = User.find(params[:id])
		if current_user!= @user
		redirect_to user_path(@current_user)
	end
	end
	
	def update
	@user = User.find(params[:id])
	    if @user.update(users_params)
	    	redirect_to user_path(@user) ,notice: 'You have updated user successfully.'
		else
			render :edit
		end
	end
	def destroy
	end
	private
	def users_params
      params.require(:user).permit(:name, :introduction, :profile_image)
    end
end
