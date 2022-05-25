class TagController < ApplicationController

  before_action :authenticate_user!
  before_action :find_tag, only: %i[update destroy show]
  before_action :find_idea, only: %i[create index]
  before_action :belonging_idea_user?, only: %i[create]
  before_action :access_update_destroy, only: %i[update destroy]

  def create
    if Tag.exists? name: tag_params[:name]
      @tag = Tag.find_by name: tag_params[:name]
      return render json: { message: "Tag has already existed" } if @tag.idea_ids.include?(@idea.id)
    else
      @tag = Tag.new(tag_params)
    end
    @tag.ideas.append @idea
    save_tag
  end


  def update
    @tag.update(tag_params)
    save_tag
  end

  def destroy
    @tag.destroy
    render json: { message: "Tag successfully deleted" }
  end

  def index
    render json: @idea.tags
  end

  def show
    render json: @tag
  end

  def get_tags
    @tags = Tag.order(:name).where('tags.name LIKE ?', "%#{params[:q]}%")
    render json: @tags
  end

  private

  def access_update_destroy
    flag = @tag.ideas.map { |idea| idea.user_ids.include?(current_user.id) } && current_user.entrepreneur?
    restrict unless current_user.admin? || flag
  end

  def tag_params
    params.require(:tag).permit!
  end

  def find_tag
    if Tag.find_by id: params[:tag_id].present?
      @tag = Tag.find params[:tag_id]
    else
      render json: { message: "Tag didn't find" }
    end
  end

  def save_tag
    if @tag.save
      render json: @tag
    else
      render json: @tag.errors.full_messages
    end
  end

end
