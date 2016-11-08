require 'geocoder'
require 'set'
require 'google_maps_service'

class TripPlannerController < ApplicationController

  def index
    
  end
  
  def trip_planning
    # convert from array to array of strings
    @path_raw = bus_route_planning(params[:trip_planner][:from], params[:trip_planner][:to])
    @path = []
    @path_raw.each do |curr_point|
      @path << (curr_point[0].to_s + "," + curr_point[1].to_s)
    end
    redirect_to trip_planner_display_route_path(path: @path)
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
    gmaps.key = "AIzaSyAOoWZdZFz8nFtVjBlWRysnSoSoSguqCII"
    route = gmaps.directions(depart_coordinates, depart_coordinates, mode: 'walking', alternatives: false)
    unless route.empty?
      return route[0]
    end
    return nil
  end
  
  def path_from_google_route(route)
    # Contains all points that define a google path
    path_points = []
    all_steps = route[:legs][0][:steps]
    all_steps.each do |curr_step|
      curr_coordinates = [curr_step[:start_location][:lat], curr_step[:start_location][:lng]]
      path_points.push(curr_coordinates)
    end
    last_coordinates = [route[:legs][0][:end_location][:lat], route[:legs][0][:end_location][:lng]]
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
  
  # Find the bus path between depart and destination stop given a certain bus route
  def find_path(route, depart_stop, destination_stop)
    depart_stop_coordinates = [depart_stop.lan, depart_stop.lon]
    destination_stop_coordinates = [destination_stop.lan, destination_stop.lon]
    mini_distance_depart = Float::INFINITY
    mini_depart_point = nil
    mini_distance_destination = Float::INFINITY
    mini_destination_point = nil
    destination_stop_coordinates = [destination_stop.lan, destination_stop.lon]
    all_path_points = Point.where(shape_id:(route.trips[0].shape_id)).order(:pt_sequence)
    all_path_points.each do |path_point|
      path_point_coordinates = [path_point.pt_lan, path_point.pt_lon]
      distance_depart = Geocoder::Calculations.distance_between(path_point_coordinates, depart_stop_coordinates)
      distance_destination = Geocoder::Calculations.distance_between(path_point_coordinates, destination_stop_coordinates)
      if(mini_distance_depart > distance_depart)
        mini_distance_depart = distance_depart
        mini_depart_point = path_point
      end
      if(mini_distance_destination > distance_destination)
        mini_distance_destination = distance_destination
        mini_destination_point = path_point
      end
    end
    
    path_points = []
    # If the depart point is ahead of the destination point, then just return the path between them, the path may
    # be something like (start point)2->3->4->5(end point).
    # But if the destination point has a smaller sequence id than the depart point, this means that in fact,
    # You need to first go to the final stop, and then start from the final stop (now become the first stop),
    # And then go to the destination point. In this case the path may be something like:
    # (start point)5->6/1(final/start point)->2(end point)
    if mini_depart_point.pt_sequence < mini_destination_point.pt_sequence
      path_points = all_path_points[mini_depart_point.pt_sequence..mini_destination_point.pt_sequence]
    else
      path_points += all_path_points[mini_depart_point.pt_sequence..-1]
      path_points += all_path_points[1..mini_destination_point.pt_sequence]
    end
    raw_point_coordinates = []
    path_points.each do |curr_point|
      raw_point_coordinates << [curr_point.pt_lan, curr_point.pt_lon]
    end
    return raw_point_coordinates
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
    final_path_points += path_from_google_route(depart_walking_route)
    
    common_routes = routes_containing_depart.to_set & routes_containing_depart.to_set
    if (not common_routes.empty?) # On the same route
      final_path_points += find_path(common_routes.to_a()[0], depart_stop, destination_stop)
    else # On different route
      min_walking_distance = Float::INFINITY
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
      final_path_points += path_of_bus_route_1
      final_path_points += path_from_google_route(transfer_walking_route)
      final_path_points += path_of_bus_route_2
    end #end of on the same or different route
    # From last bus stop to the destination
    final_path_points += path_from_google_route(destination_walking_route)
    return final_path_points
  end
end
