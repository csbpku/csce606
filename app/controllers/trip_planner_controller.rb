require 'geocoder'
require 'set'

class TripPlannerController < ApplicationController

  def index
  end
  
  def plantrip()#POST METHOD AND PLAN TRIP FOR THE USER
    
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
  
  def path_from_google_route(route)
    # Contains all points that define a google path
    path_points = []
    all_steps = route[:leg][0][:steps]
    all_steps.each do |curr_step|
      curr_coordinates = [curr_step[:start_location][:lat], curr_step[:start_location][:lng]]
      path_points.push(curr_coordinates)
    end
    last_coordinates = [route[:leg][0][:end_location][:lat], route[:leg][0][:end_location][:lng]]
    path_points.push(last_coordinates)
    return path_points
  end
  
  def find_routes_set_by_stop(stop)
    # Return a set which contains all routes including input stop
    routes_set = Array.new 
    bus_routes = Route.all
    bus_routes.each do |curr_route|
      curr_route_stops = curr_route.stops
      if(curr_route_stops.include?(stop))
        routes_set.push(curr_route)
      end
    end
    return routes_set
  end
  
  def find_path(route, depart_stop, destination_stop)
    path_points = []
    all_path_points = Point.where(shape_id:(route.trips[0].shape_id))
    route.
  end
  
  # Depart_address: string for start address
  # Destination_address: string for destination address
  # Return the path containing all coordinate points, representing the best path
  def bus_route_planning (depart_address, destination_address)
    depart_coordinates = address_to_coordinates(depart_address)
    destination_coordinates = address_to_coordinates(destination_address)
    depart_stop = find_nearest_stop(depart_coordinates)
    destination_stop = find_nearest_stop(destination_coordinates)
    
    depart_stop_coordinates = [depart_stop.lan, depart_stop.lon]
    depart_walking_route = walking_route(depart_coordinates, depart_stop_coordinates)
    destination_stop_coordinates = [destination_stop.lan, destination_stop.lon]
    destination_walking_route = walking_route(destination_stop_coordinates, destination_coordinates)
    
    # This set contains all routes including the departing stop 
    routes_containing_depart = find_routes_set_by_stop(depart_stop)
    # This set contains all routes including the destination stop 
    routes_containing_destination = find_routes_set_by_stop(destination_stop)
    
    # This array defines the shape of the routing results, it contains multiple coordinates
    final_path_points = []
    final_path_points.push(path_from_google_route(depart_walking_route))
    
    common_routes = routes_containing_depart.to_set & routes_containing_depart.to_set
    if (not common_routes.empty?) # On the same route
      final_path_points.push(find_path(common_routes.to_a()[0], depart_stop, destination_stop))
    else # On different route
      min_walking_distance = Float::IFINITY
      min_walking_route = nil
      path_of_bus_route_1 = nil
      path_of_bus_route_2 = nil
      transfer_walking_route = nil
      # Iterate all the routes in two different set
      routes_containing_depart.each do |route_1|
        routes_containing_destination.each do |route_2|
          # Iterate all the stops in both routes
          route_1.stops.each do |stop_1|
            route_2.stops.each do |stop_2|
              if(stop1.id != stop2.id) # Not the same stop
                transfer_walking_route = walking_route(stop1, stop2)
                transfer_walking_route_distance = transfer_walking_route[:legs][0][:distance][:value]
              else
                transfer_walking_route = nil
                transfer_walking_route_distance = 0
              end
              # Find the shortest transfer walking route
              if(transfer_walking_route_distance < min_walking_distance)
                min_walking_distance = transfer_walking_route_distance
                min_walking_route = transfer_walking_route
                path_of_bus_route_1 = find_path(route_1, depart_stop, stop1)
                path_of_bus_route_2 = find_path(route_2, stop2, destination_stop)
              end
            end
          end
          # End iterate all stops
        end
      end
      # End iterate all routes
      final_path_points.push(path_of_bus_route_1)
      final_path_points.push(path_from_google_route(transfer_walking_route))
      final_path_points.push(path_of_bus_route_2)
    end #end of on the same or different route
    # From last bus stop to the destination
    final_path_points.push(path_from_google_route(destination_walking_route))
    return final_path_points
  end
end
