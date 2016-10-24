class Route < ActiveRecord::Base
    has_many :trips
    has_many :shapes, through: :trips
end