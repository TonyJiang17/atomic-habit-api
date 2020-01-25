class Api::V1::SessionsController < ActionController::API

    def create
        user = User.where(email: params[:user][:email]).first 
        if user&.valid_password?(params[:user][:password])
            render json: user.as_json(only: [:email, :authentication_token]), status: :created
        else
            head(:unauthorized)
        end
    end 

    def signup
        @new_user = User.new(user_params)
        if @new_user.save
            render json: @new_user.as_json(only: [:email, :authentication_token]), status: :created
        else
            #render_error
            head(:unauthorized)
        end
    end 

    def destroy
        @user = User.find(params[:id])  
        @user.authentication_token = nil
        if @user.save
            head :no_content
        else
            head(:unauthorized)
        end
    end

    private 

    def set_user
        @user = User.find(params[:id])  
    end

    def user_params
        params.require(:user).permit(:email, :password)
    end

    def render_error
        render json: { errors: @user.errors.full_messages },
            status: :unprocessable_entity
    end
end 