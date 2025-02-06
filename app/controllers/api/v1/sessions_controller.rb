module Api
  module V1
    class SessionsController < ActionController::API
      include Devise::Controllers::SignInOut

      respond_to :json

      # POST /api/v1/login
      def create
        user = User.find_by(email: user_params[:email])
        
        if user&.valid_password?(user_params[:password])
          sign_in(user)
          render json: {
            status: { code: 200, message: 'Logged in successfully.' },
            data: {
              user: {
                id: user.id,
                email: user.email
              }
            }
          }
        else
          render json: {
            status: { code: 401, message: 'Invalid email or password.' }
          }, status: :unauthorized
        end
      end

      # GET /api/v1/check_auth
      def check_auth
        if current_user
          render json: {
            status: { code: 200, message: 'User is authenticated.' },
            data: {
              user: {
                id: current_user.id,
                email: current_user.email
              }
            }
          }
        else
          render json: {
            status: { code: 401, message: 'User is not authenticated.' }
          }, status: :unauthorized
        end
      end

      # DELETE /api/v1/logout
      def destroy
        if current_user
          sign_out(current_user)
          render json: {
            status: { code: 200, message: 'Logged out successfully.' }
          }
        else
          render json: {
            status: { code: 401, message: 'Not logged in.' }
          }, status: :unauthorized
        end
      end

      private

      def user_params
        params.require(:user).permit(:email, :password)
      end
    end
  end
end 