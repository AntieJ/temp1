class Api::V1::InvestmentsController < ApplicationController
  skip_forgery_protection

  def create
    campaign = Campaign.find(params[:campaign_id])
    investment = campaign.investments.new(investment_params)
    if investment.save
      render json: InvestmentSerializer.new(investment).serializable_hash
    else
      render json: { message: investment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def investment_params
    params.require(:investment).permit(:amount)
  end
end
