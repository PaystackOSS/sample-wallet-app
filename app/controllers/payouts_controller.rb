class PayoutsController < ApplicationController
  def new
    @payout = Payout.new
  end

  def create
    @payout = Payout.new(payout_params)
  end
  
  private
  # Only allow a list of trusted parameters through.
  def payout_params
    params.permit(:amount, :recipient_code, :user)
  end
end
