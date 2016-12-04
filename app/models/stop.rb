class Stop < ActiveRecord::Base
    has_many :stop_times
    # has_and_belongs_to_many :trips
end