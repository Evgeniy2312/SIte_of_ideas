require 'rails_helper'
require_relative '/app/controllers/users/session_controller.rb'

RSpec.describe AdminController, type: :controller do
  describe "GET /app/controllers/admin/index " do

    context 'получает всех пользователей' do
      let(:request){ get '/admin'}
      let(:user){ create(:user, role: 3) }
      before do
        sign_in user
        request
      end

      it 'отвечает с кодом 200' do
        expect(response).to have_http_status(:ok)
      end

      it_behaves_like 'отдает json ошибку'
    end
  end
end
