
class MapsearchController < ApplicationController
  def search
  	@data = Buildings.all
  	@parsedDataLatitudes = Array.new
  	@parsedDataLongitudes = Array.new
  	@data.each do |dt|
  		@parsedDataLatitudes.push(dt.lan)
  		@parsedDataLongitudes.push(dt.lon)
  	end
    #Change is view script
  end
end