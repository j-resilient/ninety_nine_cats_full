class CatsController < ApplicationController
    before_action :check_user_logged_in, only: [:new, :create]

    def check_user_logged_in
        redirect_to new_user_url if current_user.nil?
    end

    def index
        render :index
    end

    def show
        @current_cat = Cat.find_by(id: params[:id])
        if @current_cat
            render :show
        else
            flash.now[:errors] = ["Could not find cat."]
            render :index
        end
    end

    def new
        @cat = Cat.new
        render :new
    end

    def create
        @cat = Cat.new(cat_params)
        @cat.user_id = current_user.id
        if @cat.save
            redirect_to cat_url(@cat)
        else
            flash.now[:errors] = @cat.errors.full_messages
            render :new
        end
    end

    def edit
        @cat = Cat.find_by(id: params[:id])
        render :edit
    end

    def update
        @cat = Cat.find_by(id: params[:id])
        
        if @cat.update(cat_params)
            redirect_to cat_url
        else
            flash.now[:errors] = @cat.errors.full_messages
            render :edit
        end
    end

    private
    def cat_params
        params.require(:cat).permit(:birth_date, :color, :name, :sex, :description)
    end
end