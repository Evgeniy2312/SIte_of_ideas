class CommentController < ApplicationController
  before_action :authenticate_user!
  before_action :find_comment, only: %i[update destroy show create_under_comment show_under_comment]
  before_action :find_idea, only: %i[create show_comment_to_idea]
  before_action :belonging_to_user_comment?, only: %i[update destroy]

  def create
    @comment = Comment.new(**comment_params, idea: @idea, user: current_user)
    save_comment
  end

  def update
    @comment.update(comment_params)
    save_comment
  end

  def destroy
    @comment.destroy
    render json: { message: "Comment deleted successfully" }
  end

  def show
    render json: @comment
  end

  def show_comment_to_idea
    render json: @idea.comments
  end

  def show_under_comment
    render json: @comment.comments
  end

  def create_under_comment
    child_comment = Comment.new(**comment_params, idea: @comment.idea,
                                user: current_user, parent_comment: @comment)
    if child_comment.save
      render json: child_comment
    else
      render json: child_comment.errors.full_messages
    end
  end

  private

  def save_comment
    if @comment.save
      render json: @comment
    else
      render json: @comment.errors.full_messages
    end
  end

  def comment_params
    params.require(:comment).permit!
  end

  def find_comment
    if Comment.find_by id: params[:comment_id]
      @comment = Comment.find params[:comment_id]
    else
      render json: { message: "Comment don't found" }
    end
  end

  def belonging_to_user_comment?
    restrict unless current_user.comment_ids.include?(@comment.id) || current_user.admin?
  end
end
