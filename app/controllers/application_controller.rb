class ApplicationController < ActionController::API

  before_action :configure_permitted_parameters, if: :devise_controller?

  def restrict
    render json: {
      status: { code: 400, message: 'Restricted' } }
  end

  def find_idea
    if Idea.find_by(id: params[:id]).present?
      @idea = Idea.find params[:id]
    else
      render json: { message: "Idea didn't find" }
    end
  end

  def belonging_idea_user?
    restrict unless current_user.admin? || (current_user.entrepreneur? && @idea.user_ids.include?(current_user.id))
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :password, :password_confirmation, :current_password,
                                                       :role, address_attributes: [:country, :skype, :telephone]])
  end
end
