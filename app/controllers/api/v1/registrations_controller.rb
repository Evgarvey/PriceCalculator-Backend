module Api
  module V1
    class RegistrationsController < ActionController::API
      # Remove the skip_before_action since API controllers don't need CSRF protection
      
      # POST /api/v1/signup
      def create
        @user = User.new(user_params)
        
        if @user.save
          render json: {
            status: { code: 200, message: 'Signed up successfully.' },
            data: {
              user: {
                id: @user.id,
                email: @user.email
              }
            }
          }
        else
          render json: {
            status: { 
              code: 422, 
              message: 'User could not be created.',
              errors: @user.errors.full_messages
            }
          }, status: :unprocessable_entity
        end
      end

      private

      def user_params
        params.require(:user).permit(:email, :password, :password_confirmation)
      end
    end
  end
end 