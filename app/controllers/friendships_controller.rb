class FriendshipsController < ApplicationController
	def create
		friendship = Friendship.new(friendship_params)
		friendship.follower = current_user

		flash[:error] = "Couldn't follow. Please Try Again!" unless friendship.save
		redirect_to friendship.followed
	end

	def destroy
		friendship = Friendship.find(params[:id])
		user = friendship.followed
		friendship.destroy
		redirect_to user
	end

	def friendship_params
		params.require(:friendship).permit(:follower_id, :followed_id)
	end
end
