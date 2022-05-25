class DislikeController < ApplicationController
  before_action :authenticate_user!
  before_action :find_idea

  def create
    @idea.dislikes.append(Dislike.new(user: current_user)) unless exist?
    render json: @idea.dislikes.count
  end

  def destroy
    Dislike.find_by(user: current_user).destroy if exist?
    render json: @idea.dislikes.count
  end

  def get_amount_dislikes
    render json: @idea.dislikes.count
  end

  private

  def exist?
    true if @idea.dislikes.exists?(user: current_user)
  end

end
