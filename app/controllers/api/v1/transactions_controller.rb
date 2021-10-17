class Api::V1::TransactionsController < ApplicationController
  def create
    CreateTransactionJob.perform_later(transaction_params)
    render json: 'Work in progress', status: 200
  end

  private
  
  def transaction_params
    params.require(:data)
      .permit(
        :name, 
        :amount, 
        :user_id, 
        :to_user_id
      ).to_h.symbolize_keys
  end
end