class Api::V1::CampaignsController < ApplicationController
  def index
    campaigns = Campaign.all
    campaigns = campaigns.by_sector(params[:sector]) if params[:sector].present?
    campaigns = campaigns.by_investments_count(
      params[:investments_count][:from],
      params[:investments_count][:to]
    ) if params[:investments_count].present?
    render json: CampaignSerializer.new(campaigns).serializable_hash
  end
end
