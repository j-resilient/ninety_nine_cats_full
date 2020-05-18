class CatRentalRequestsController < ApplicationController
    def new
        render :new
    end

    def create
        new_request = CatRentalRequest.create(request_params)
        if new_request.save!
            redirect_to cat_url(request_params[:cat_id])
        else
            render plain: "Could not save request."
        end
    end

    private
    def request_params
        params.require(:request).permit(:cat_id, :start_date, :end_date)
    end
end