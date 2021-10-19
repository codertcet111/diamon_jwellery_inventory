module Transnable
  extend ActiveSupport::Concern
  included do
    has_many :transactions, :as => :transnable
  end
end