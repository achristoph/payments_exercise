require 'rails_helper'

RSpec.describe PaymentsController, type: :controller do

  let(:loan) { Loan.create!({ id: 1, funded_amount: 100, balance: 100 }) }

  describe '#index' do
    it 'responds with a 200' do
      get :index
      expect(response).to have_http_status(:ok)
    end
  end

  describe '#show' do
    let(:payment) { Payment.create!(payment_amount: 10.0, payment_date: '1/1/2016', loan: loan) }
    it 'responds with a 200' do
      get :show, id: payment.id
      expect(response).to have_http_status(:ok)
    end
  end

  describe '#create' do
    it 'responds with a 201' do
      Loan.create!({ id: 1, funded_amount: 100, balance: 100 })
      post :create, { payment: { payment_amount: 10.0, payment_date: '1/1/2016' }, loan_id: 1 }
      expect(response).to have_http_status(:created)
    end

    it 'responds with a 400 when the payment amount is invalid' do
      Loan.create!({ id:1, funded_amount: 100, balance: 0 })
      post :create, { payment: { payment_amount: 10.0, payment_date: '1/1/2016' }, loan_id: 1 }
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'does not create a payment more than the balance of the loan' do
      Loan.create!({ id: 1, funded_amount: 100, balance: 100 })
      post :create, { payment: { payment_amount: 10.0, payment_date: '1/1/2016' }, loan_id: 1 }
      expect(response).to have_http_status(:created)
      post :create, { payment: { payment_amount: 99.0, payment_date: '1/1/2016' }, loan_id: 1 }
      expect(response).to have_http_status(:unprocessable_entity)
      response_body = JSON.parse response.body
      expect(response_body["error"]["base"]).to eq(["Payment must no be larger than the loan balance"])
    end
  end

  context 'if the payment is not found' do
    it 'responds with a 404' do
      get :show, id: 10000
      expect(response).to have_http_status(:not_found)
    end
  end

end
