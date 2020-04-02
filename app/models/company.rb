class Company < ApplicationRecord
    has_many:stocks,
    dependent: :destroy
end
