library('geosphere')

readmyGPSData = function() {
	#folder = "C:/Users/cristian.chilipirea/Dropbox/Projects/Assen2016/myGPS/detections/"
	folder = "D:/Dropbox/Projects/Assen2016/myGPS/detections/"
	files = dir(folder)
	files = paste(folder, files, sep="")
	rezult = data.frame()
	for(i in 1:length(files)) {
	  rezult = rbind(rezult , read_csv(files[i]))
	}

	rezult$time = as.numeric(rezult$time)
	rezult = rezult[,c("lat", "lon", "time")]
	colnames(rezult) = c("latitude", "longitude", "time")
	rezult = rezult[order(rezult$time),]
	return(rezult)
}

writeGPS = function(gps_data) {
	dets = paste(gps_data$time, gps_data$lat, gps_data$lon, sep = ", ")
	dets = paste(dets, collapse = "], [")
	dets = paste("var gpsPositions = [[", dets, "]];", sep="")
	write(file="C:/Users/cristian.chilipirea/Dropbox/Assen2016/movements_individual_2016_modular_GPS/scripts/data/gpsPositions.js", dets)
	
}

readStopLocations = function() {
  #fileName = "C:/Users/cristian.chilipirea/Dropbox/Projects/Assen2016/myGPS/InterestingLocations.csv"
  fileName = "D:/Dropbox/Projects/Assen2016/myGPS/InterestingLocations.csv"
	stopLocations <- read.csv(fileName)
	stopLocations$locationName = as.character(stopLocations$locationName)
	return(stopLocations)
}

addLabelsToGPSData= function(GPSDetections, stopLocations) {
  GPSDetections$label = "None"
  for(i in 1:nrow(stopLocations)) {
    selector = distGeo(GPSDetections[,c("latitude","longitude")],stopLocations[i,c("latitude","longitude")]) < 100
    GPSDetections$label[selector] = stopLocations$locationName[i]
  }
  GPSDetections$isMoving = GPSDetections$label=="None"
  return(GPSDetections)
}

GPSDetections = readmyGPSData()
stopLocations = readStopLocations()
#writeGPS(gps_data)
GPSDetections = addLabelsToGPSData(GPSDetections, stopLocations)

rm(list = lsf.str())