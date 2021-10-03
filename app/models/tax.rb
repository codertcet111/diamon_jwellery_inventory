class Tax < ApplicationRecord
	has_many :purchases
	has_many :sales
end
