class RateController < ApplicationController
  before_action :authenticate_user!
  before_action :find_idea
  before_action :belonging_idea_user?, only: %i[destroy]
  before_action :get_rate, except: %i[create]
  before_action :filter_update_rate, only: %i[update]

  def create
    if @idea.rate.present?
      @rate = @idea.rate
      return ban_rate if @rate.user_ids.include?(current_user.id)

      @rate.mark = (@rate.mark + params_rate[:mark]) / 2
    else
      @rate = Rate.new(**params_rate, idea: @idea)
    end
    @rate.users.append current_user
    save_rate
  end

  def destroy
    @rate.destroy
    render json: {
      status: { code: 200, message: 'Rate deleted successfully' }
    }
  end

  def update
    @rate.mark = (@rate.mark + params_rate[:mark]) / 2
    save_rate
  end

  def get_rate_idea
    render json: @rate
  end

  private

  def ban_rate
    render json: { message: "You have already rated it's idea!" }
  end

  def params_rate
    params.require(:rate).permit!
  end

  def get_rate
    if @idea.rate.present?
      @rate = @idea.rate
    else
      render json: { message: "Rate doesn't exist" }
    end
  end

  def save_rate
    if @rate.save
      render json: @rate
    else
      render json: @rate.errors.full_messages
    end
  end

  def filter_update_rate
    restrict unless @rate.user_ids.include?(current_user.id) || current_user.admin?
  end

end
