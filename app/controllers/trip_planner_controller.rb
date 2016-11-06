require 'geocoder'


class TripPlannerController < ApplicationController
  def index
  end
  
  def address_to_coordinates (address)
    #Call geocode and return coordinates
  end
  
  def find_nearest_stop(raw_coordinates)
    #return a nearest station
  
  end
  
  def walking_route(depart_coordinates, destination_coordinates)
    #return a walking route object
  end
  
  def find_routes_set_by_stop(stop)
    #return a set which contains all routes including input stop
  end
  
  def bus_route_planning (depart_location, destination_location)
    depart_coordinates = address_to_coordinates(depart_location)
    destination_coordinates = address_to_coordinates(destination_location)
    depart_stop = find_nearest_stop(depart_coordinates)
    destination_stop = find_nearest_stop(destination_coordinates)
    
    
    depart_walking_route = walking_route(depart_coordinates, depart_stop.coordinates)
    destination_walking_route = walking_route(destination_stop.coordinates, destination_coordinates)
    
    #S is the set which contains all routes including the departing stop 
    S = find_routes_set_by_stop(depart_stop)
    #D is the set which contains all routes including the destination stop 
    D = find_routes_set_by_stop(destination_stop)
    
    R = S&D
    if ( R != nil)
      for r in R do
        
      end
    
    else
  end
end
