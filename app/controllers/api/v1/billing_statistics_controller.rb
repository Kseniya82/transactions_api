class Api::V1::BillingStatisticsController < ApplicationController
  def create
    CreateBillingStatisticJob.perform_later(statistic_params)
    render json: 'Work in progress', status: 200
  end

  def show
    render json: User.find_by(id: params['user_id']).billing_statistic.content, status: 200
  end

  private

  def statistic_params
    params.require(:data)
      .permit(
        :date_from, 
        :date_to, 
        :user_id
      ).to_h.symbolize_keys
  end
end