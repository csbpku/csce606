class Route < ActiveRecord::Base
    has_many :trips
    has_many :points, through: :trips
    has_many :stop_times, through: :trips
    has_many :stops, through: :stop_times
end