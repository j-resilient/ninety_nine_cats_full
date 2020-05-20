class CatRentalRequestsController < ApplicationController
    def new
        render :new
    end

    def create
        new_request = CatRentalRequest.new(request_params)
        if new_request.save
            redirect_to cat_url(request_params[:cat_id])
        else
            flash.now[:errors] = new_request.errors.full_messages
            render :new
        end
    end

    def approve
        request = CatRentalRequest.find_by(id: params[:id])
        request.approve!
        redirect_to cat_url(request.cat_id)
    end

    def deny
        request = CatRentalRequest.find_by(id: params[:id])
        request.deny!
        redirect_to cat_url(request.cat_id)
    end

    private
    def request_params
        params.require(:request).permit(:cat_id, :start_date, :end_date)
    end
end