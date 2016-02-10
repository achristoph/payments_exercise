class Payment < ActiveRecord::Base
  belongs_to :loan

  validate :must_be_valid_amount

  def must_be_valid_amount
    errors.add(:base, 'Payment must no be larger than the loan balance') unless payment_amount <= self.loan.balance
  end
end
