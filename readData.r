library('geosphere')
library('readr')

readmyGPSData = function() {
	#folder = "C:/Users/cristian.chilipirea/Dropbox/Projects/Assen2016/myGPS/detections/"
	folder = "C:/Users/cristian.chilipirea/Dropbox/Projects/Assen2016/MaartenGPS/detections/"
	files = dir(folder)
	files = paste(folder, files, sep="")
	rezult = data.frame()
	for(i in 1:length(files)) {
	  print(files[i])
	  rezult = rbind(rezult , read_csv(files[i]))
	}

	rezult$time = as.numeric(rezult$time)
	rezult = rezult[,c("latitude", "longitude", "time", "speed (km/h)")]
	#colnames(rezult) = c("latitude", "longitude", "time")
	rezult = rezult[order(rezult$time),]
	return(rezult)
}

writeGPS = function(gps_data) {
	dets = paste(gps_data$time, gps_data$latitude, gps_data$longitude, sep = ", ")
	dets = paste(dets, collapse = "], [")
	dets = paste("var gpsPositions = [[", dets, "]];", sep="")
	write(file="C:/Users/cristian.chilipirea/Dropbox/Assen2016/movements_individual_2016_modular_GPS/scripts/data/gpsPositions.js", dets)
	
}

readStopLocations = function() {
  #fileName = "C:/Users/cristian.chilipirea/Dropbox/Projects/Assen2016/myGPS/InterestingLocations.csv"
  fileName = "MaartenGPS/InterestingLocations.csv"
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

#GPSDetections2 = readmyGPSData()
#writeGPS(GPSDetections)
stopLocations2 = readStopLocations()
#writeGPS(gps_data)
GPSDetections2 = addLabelsToGPSData(GPSDetections2, stopLocations2)

rm(list = lsf.str())

#GPSDetections$isMoving = c(F, GPSDetections$isMoving[-nrow(GPSDetections)]) | GPSDetections$isMoving