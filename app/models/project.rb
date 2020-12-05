class Project < ActiveRecord::Base
  belongs_to :partner
  has_many :invoices
end
