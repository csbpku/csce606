class Trip < ActiveRecord::Base
    has_many :stop_times
    has_many :stops, through: :stop_times
    has_many :shapes
    has_one :calendar
    belongs_to :route
end