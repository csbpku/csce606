class Trip < ActiveRecord::Base
    has_many :stop_times
    has_many :stops, through: :stop_times
    has_one :calendar
    belongs_to :route
    # has_and_belongs_to_many :stops
end