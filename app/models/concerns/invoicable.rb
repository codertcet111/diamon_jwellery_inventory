module Invoicable
  extend ActiveSupport::Concern
  included do
    has_many :transactions, :as => :invoicable
  end
end