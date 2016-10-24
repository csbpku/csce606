class Stop_time < ActiveRecord::Base
    belongs_to :stop
    belongs_to :trip
end