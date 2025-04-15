class LoginController < ApplicationController

    def new
    end

    def create
        user = User.find_by(email: params[:email])

        if user&.authenticate(params[:password])
            session[:user_id] = user.id
            redirect_to root_path, notice: "Logged in!"
        else
            flash.now[:alert] = "Invalid email or password"
            render :new, status: :unprocessable_entity
        end
    end
end
