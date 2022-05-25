class AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :test_role
  before_action :find_user, only: %i[show destroy]

  def index
    render json: User.all
  end

  def show
    render json: @user
  end

  def destroy
    @user.destroy
    render json: { message: "User deleted" }
  end

  def find_by_role
    user = User.where(role: params[:role])
    if user.present?
      render json: user
    else
      render json: { message: "User didn't find with this role" }
    end
  end

  private

  def find_user
    if User.find_by(id: params[:id])
      @user = User.find params[:id]
    else
      render json: { message: "User didn't find" }
    end
  end

  def test_role
    restrict unless current_user.admin?
  end

end
