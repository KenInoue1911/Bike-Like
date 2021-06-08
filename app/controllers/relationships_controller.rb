class RelationshipsController < ApplicationController
  def create
    current_user.follow(params[:id])
  end
  
  def destroy
    current_user.unfollow(params[:id])
  end
end
