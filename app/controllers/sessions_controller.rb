class SessionsController < ApplicationController
    def new
        render :new
    end

    def create
        #verify credentials
        user =  User.find_by_credentials(
            session_params[:user_name],
            session_params[:password]
        )

        if user.nil?
            flash.now[:errors] = ["Incorrect username or password."]
            render :new
        else
            login_user!(user)
            redirect_to cats_url
        end
    end

    def destroy
        logout!
        redirect_to new_session_url
    end

    private
    def session_params
        params.require(:session).permit(:user_name, :password)
    end
end