module Invoicable
  extend ActiveSupport::Concern
  included do

    has_many :transactions, :as => :invoicable

    validates_uniqueness_of :invoice_number, allow_blank: true

  end
end