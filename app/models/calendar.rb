class Calendar < ActiveRecord::Base
    has_many :trips
    has_many :calendar_dates
end