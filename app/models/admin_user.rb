class AdminUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :validatable

  has_many :invoices
  has_many :bank_transactions


  def beweekly_salary_amount
    ENV['BEWEEKLY_SALARY_AMOUNT'] || 33.11
  end
end
