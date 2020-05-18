class CatRentalRequestsController < ApplicationController
    def new
        render :new
    end

    def create
        new_request = CatRentalRequest.create(request_params)
        if new_request.save
            redirect_to cat_url(request_params[:cat_id])
        else
            render json: new_request.errors.full_messages, status: unprocessable_entity
        end
    end

    private
    def request_params
        params.require(:request).permit(:cat_id, :start_date, :end_date)
    end
end