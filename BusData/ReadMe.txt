This folder contains:
-datahelper folder: deals with the original GTFS bus data by replacing the hash primary/foreign keys to integers
-combinedData folder: contains the processed bus data
-import_busdata.sh: import bus data to corresponding tables

run ./import_busdata.sh, and it takes some time to write these records to the database
