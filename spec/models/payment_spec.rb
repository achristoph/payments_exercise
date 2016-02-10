require 'rails_helper'

RSpec.describe Payment, type: :model do
  it 'creates a payment correctly' do
    l = Loan.create
    payment = Payment.new(payment_amount: 10, payment_date: '1/1/2016')
    payment.loan = l
    expect(payment.payment_amount).to eq(10)
    expect(payment.payment_date).to eq(DateTime.parse('1/1/2016'))
    expect(payment.loan).to eq(l)
  end

  it 'produces error when payment amount is larger than the loan balance' do
    l = Loan.create(balance: 50)
    payment = Payment.new(payment_amount: 100, payment_date: '1/1/2016')
    payment.loan = l
    expect(payment.save).to be(false)
    expect(payment.errors.size).to eq(1)
  end
end
