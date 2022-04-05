class InvitationsController < ApplicationController
  def create
    @cycle = Cycle.find(params[:cycle_id])
    @invitation = Invitation.new(invitation_params)
    @invitation.cycle = @cycle
    @invitation.save
  end

  private

  def invitation_params
    params.require(:invitation).permit(:email, :message)
  end
end





    # if @review.save
    #   redirect_to restaurant_path(@restaurant)
    # else
    #   render 'restaurants/show'
    # end
