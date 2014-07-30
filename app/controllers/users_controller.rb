class UsersController < ApplicationController
	
	def index
		@users = User.all
		@status = Status.new
	end

	def new
		if current_user
			redirect_to friends_path
		else
			@user = User.new
		end
	end

	def create
		@user = User.new(user_params)
		if @user.save
			session[:user_id] = @user.id
			redirect_to @user, notice: "Thank you for signing up!"
		else
			render 'new'
		end
	end

	def show
		@user = User.find(params[:id])
		@status = Status.new
		@statuses = Status.all
		@friendship = Friendship.where(
			follower_id: current_user.id,
			followed_id: @user.id
		).first_or_initialize if current_user
	end

	def edit
		@user = User.find(params[:id])
		redirect_to @user unless @user == current_user
	end

	def update
		@user = User.find(params[:id])
		if @user.update_attributes(user_params)
			redirect_to @user, notice: "Profile Updated."
		else
			render 'edit'
		end
	end

	def friends
		if current_user
			@status = Status.new
			friends_ids = current_user.followeds.map(&:id).push(current_user.id)
			@statuses = Status.find_all_by_user_id friends_ids
		else
			redirect_to root_url
		end
	end

	private

	def user_params
		params.require(:user).permit(:name, :username, :email, :password, :password_confirmation, :bio)
	end

end
