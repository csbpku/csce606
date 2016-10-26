java DeleteColumn routes.txt agency_id n_routes.txt
mv n_routes.txt routes.txt

# Replace stop_id
java ReplaceForeignKey stops.txt stop_id stop_times.txt n_stop_times.txt
mv n_stop_times.txt stop_times.txt
java ReplacePrimKey stops.txt stop_id n_stops.txt
mv n_stops.txt stops.txt

# Replace route_id
java ReplaceForeignKey routes.txt route_id trips.txt n_trips.txt
mv n_trips.txt trips.txt
java ReplacePrimKey routes.txt route_id n_routes.txt
mv n_routes.txt routes.txt

# Replace shape_id
java ReplaceForeignKey shapes.txt shape_id trips.txt n_trips.txt
mv n_trips.txt trips.txt
java ReplacePrimKey shapes.txt shape_id n_shapes.txt
mv n_shapes.txt shapes.txt

# Replace trip_id
java ReplaceForeignKey trips.txt trip_id stop_times.txt n_stop_times.txt
mv n_stop_times.txt stop_times.txt
java ReplacePrimKey trips.txt trip_id n_trips.txt
mv n_trips.txt trips.txt

# Replace calendar_id
java ReplaceForeignKey calendar.txt service_id trips.txt n_trips.txt
mv n_trips.txt trips.txt
java ReplaceForeignKey calendar.txt service_id calendar_dates.txt n_calendar_dates.txt
mv n_calendar_dates.txt calendar_dates.txt
java ReplacePrimKey calendar.txt service_id n_calendar.txt
mv n_calendar.txt calendar.txt


