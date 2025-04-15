class AuthController < ApplicationController

    def register
        @user = User.new
    end

    def create
        @user = User.new(user_params)

        if @user.save

            session[:user_id] = @user.id
          redirect_to root_path, notice: "Account created successfully"
        else
            puts "DEBUG: errors = #{@user.errors.full_messages}"
          render :register, status: :unprocessable_entity
        end
    end

    def login
    end

    def authenticate
        user = User.find_by(email: params[:email])

        if user&.authenticate(params[:password])
            session[:user_id] = user.id
            redirect_to root_path, notice: "Logged in!"
        else
            flash.now[:alert] = "Invalid email or password"
            render :login, status: :unprocessable_entity
        end
    end

  private

    def user_params
        params.require(:user).permit(:email, :password, :password_confirmation)
    end
end
