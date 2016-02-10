require 'rails_helper'

RSpec.describe Loan, type: :model do
  describe '#new' do
    it 'creates a payment correctly' do
      loan = Loan.create(funded_amount: 0, balance: 10)
      expect(loan.funded_amount).to eq(0)
      expect(loan.balance).to eq(10)
    end
  end
end
