require 'geocoder'


class TripPlannerController < ApplicationController
  
  def index
  end
  
  def address_to_coordinates (address)
    # Call geocode and return coordinates
    geocoder_results = Geocoder.search(address)
    unless geocoder_results.empty?
      coordinates = geocoder_results[0].coordinates
      return coordinates
    end
    return nil
  end
  
  def find_nearest_stop (raw_coordinates)
    # Return a nearest station
    stops = Stop.all
    min_distance = Float::INFINITY
    nearest_stop = nil
    stops.each do |curr_stop|
      curr_stop_coordinates = [curr_stop.lan, curr_stop.lon]
      distance = Geocoder::Calculations.distance_between(curr_stop_coordinates, raw_coordinates)
      if distance < min_distance
        min_distance = distance
        nearest_stop = curr_stop
      end
    end
    return nearest_stop
  end
  
  def walking_route(depart_coordinates, destination_coordinates)
    # Return a walking route object
    gmaps = GoogleMapsService::Client.new()
    gmaps.key = ""
    route = gmaps.directions(depart_coordinates, depart_coordinates, mode: 'walking', alternatives: false)
    unless route.empty?
      return route[0]
    end
    return nil
  end
  
  def find_routes_set_by_stop(stop)
    # Return a set which contains all routes including input stop
    bus_routes = Route.all
    bus_routes.each do |curr_route|
      curr_route_stops = curr_route.trips.stops
    end
    return nil
  end
  
  def bus_route_planning (depart_location, destination_location)
    depart_coordinates = address_to_coordinates(depart_location)
    destination_coordinates = address_to_coordinates(destination_location)
    depart_stop = find_nearest_stop(depart_coordinates)
    destination_stop = find_nearest_stop(destination_coordinates)
    
    
    depart_walking_route = walking_route(depart_coordinates, depart_stop.coordinates)
    destination_walking_route = walking_route(destination_stop.coordinates, destination_coordinates)
    
    #S is the set which contains all routes including the departing stop 
    routes_containing_depart = find_routes_set_by_stop(depart_stop)
    #D is the set which contains all routes including the destination stop 
    routes_containing_destination = find_routes_set_by_stop(destination_stop)
    
    final_route_set=[]
    common_routes = routes_containing_depart & routes_containing_depart
    if ( common_routes != nil)
      common_routes.each do |common_route|
          
      end
    else
      
    end
  end
end
