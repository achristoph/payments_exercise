class PaymentsController < ApplicationController

  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: 'not_found', status: :not_found
  end

  def index
    render json: Payment.all
  end

  def show
    render json: Payment.find(params[:id])
  end

  def create
    loan = Loan.find(params[:loan_id])
    payment = Payment.new(payment_params)
    payment.loan = loan
    if payment.save
      render json: params, status: :created
    else
      render json: {
        error: payment.errors
      }, status: :unprocessable_entity
    end
  end

  private
  def payment_params
    params.require(:payment).permit(:payment_amount, :payment_date, :loan_id)
  end
end
