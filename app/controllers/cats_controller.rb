class CatsController < ApplicationController
    def index
        render :index
    end

    def show
        @current_cat = Cat.find_by(id: params[:id])
        if @current_cat
            render :show
        else
            render plain: "Could not find cat."
        end
    end

    def new
        @cat = Cat.new
        render :new
    end

    def create
        new_cat = Cat.create(cat_params)
        if new_cat.save
            redirect_to cats_url
        else
            render json: new_cat.errors.full_messages, status: unprocessable_entity
        end
    end

    def edit
        @cat = Cat.find_by(id: params[:id])
        render :edit
    end

    def update
        cat = Cat.find_by(id: params[:id])

        if cat.update(cat_params)
            redirect_to cat_url
        else
            render json: cat.errors.full_messages
        end
    end

    private
    def cat_params
        params.require(:cat).permit(:birth_date, :color, :name, :sex, :description)
    end
end