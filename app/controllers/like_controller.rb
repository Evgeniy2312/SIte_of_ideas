class LikeController < ApplicationController
  before_action :authenticate_user!
  before_action :find_idea

  def create
    @idea.likes.append(Like.new(user: current_user)) unless exist?
    render json: @idea.likes.count
  end

  def destroy
    Like.find_by(user: current_user).destroy if exist?
    render json: @idea.likes.count
    binding.pry
  end

  def get_amount_likes
    render json: @idea.likes.count
  end

  private

  def exist?
    true if @idea.likes.exists?(user: current_user)
  end

end
