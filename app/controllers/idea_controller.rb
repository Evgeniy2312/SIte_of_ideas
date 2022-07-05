class IdeaController < ApplicationController
  before_action :authenticate_user!
  before_action :find_idea, only: %i[update show destroy update_status add_investor_to_idea]
  before_action :belonging_idea_user?, only: %i[update destroy update_status]
  before_action :test_role_to_entrepreneur, only: %i[create]
  before_action :test_role_to_investor, only: %i[add_investor_to_idea]
  before_action :contains_investor, only: %i[add_investor_to_idea]

  def create
    @idea = Idea.new(idea_params)
    @idea.users.append current_user
    save_idea
    send_to_email
  end

  def add_investor_to_idea
    @idea.users.append current_user
    render json: {
      status: { code: 200, message: 'You invested this idea!' }
    }
  end

  def update
    @idea.update(idea_params)
    save_idea
  end

  def destroy
    @idea.destroy
    render json: {
      status: { code: 200, message: 'Idea deleted successfully' }
    }
  end

  def index
    @ideas = current_user.ideas.order(:name).page(params[:page])
    rendering_ideas
  end

  def show
    case @idea.access
    when 'personal'
      rendering_idea if @idea.user_ids.include?(current_user.id)
    when 'common'
      rendering_idea
    else
      render json: { message: "Something gone wrong!" }
    end
  end

  def show_all_ideas
    @ideas = Idea.common.order(:name).page(params[:page])
    rendering_ideas
  end

  def update_status
    @idea.access = params[:access]
    send_to_email
    save_idea
  end

  def get_by_sphere
    @ideas = Idea.where(sphere: params[:sphere]).order(:name).page(params[:page])
    rendering_ideas
  end

  def get_by_problem
    @ideas = Idea.where(problem: params[:problem]).order(:name).page(params[:page])
    rendering_ideas
  end

  def get_by_location
    @ideas = Idea.where(location: params[:location]).order(:name).page(params[:page])
    rendering_ideas
  end

  def get_by_name
    @ideas = Idea.where(name: params[:name]).order(:name).page(params[:page])
    rendering_ideas
  end

  def get_by_tag
    @ideas = Idea.joins(:tags).where(tags: { name: params[:tag_name] }).order(:name).page(params[:page])
    rendering_ideas
  end

  def get_by_author
    @ideas = Idea.joins(:users).where(users: { role: "entrepreneur", name: params[:name_author] }).order(:name)
                 .page(params[:page])
    rendering_ideas
  end

  def get_by_rate
    @ideas = Idea.joins(:rate).where(rates: { mark: params[:rate_idea] }).order(:name).page(params[:page])
    rendering_ideas
  end

  def get_by_amount_like
    @ideas = []
    get_ideas_by_amount_like
    rendering_ideas
  end

  private

  def get_ideas_by_amount_like
    Idea.joins(:likes).page(params[:page]).find_each do |idea|
      @ideas.push idea if idea.likes.count >= params[:amount].to_i
    end
  end

  def test_role_to_entrepreneur
    restrict unless current_user.entrepreneur?
  end

  def test_role_to_investor
    restrict unless current_user.investor?
  end

  def contains_investor
    render json: { message: "You have already invested " } if @idea.user_ids.include?(current_user.id)
  end

  def idea_params
    params.require(:idea).permit!
  end

  def save_idea
    if @idea.save
      rendering_idea
    else
      render json: @idea.errors.full_messages
    end
  end

  def rendering_ideas
    render json: @ideas.as_json(include: %i[users comments dislikes likes rate tags])
  end

  def rendering_idea
    render json: @idea.as_json(include: %i[users comments dislikes likes rate tags])
  end

  def send_to_email
    if @idea.common?
      User.where(role: "investor").each do |user|
        UserMailer.with(user: user, idea: @idea).appeared_idea.deliver_now
      end
    end
  end
end


