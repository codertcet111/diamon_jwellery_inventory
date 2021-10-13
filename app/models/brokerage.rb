class Brokerage < ApplicationRecord
  belongs_to :broker
  belongs_to :purchase, optional: true
  belongs_to :sale, optional: true
  belongs_to :broker
  enum payment_mode: [:cash,:cheque,:angadia,:rtgs_neft, :other]
end
