class UsersController < ApplicationController
    before_action :check_if_already_logged_in

    def check_if_already_logged_in
        redirect_to cats_url if current_user
    end

    def new
        render :new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            login_user!(@user)
            redirect_to cats_url
        else
            flash.now[:errors] = @user.errors.full_messages
            render :new
        end
    end

    private
    def user_params
        params.require(:user).permit(:user_name, :password)
    end
end