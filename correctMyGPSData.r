GPSDetections$isMoving = c(F, GPSDetections$isMoving[-nrow(GPSDetections)]) | GPSDetections$isMoving

# bcr stay is static
GPSDetections$isMoving[GPSDetections$time>=1503324063.657 & GPSDetections$time<=1503324491.072] = F

#carefour is static
GPSDetections$isMoving[GPSDetections$time>=1503667726.106 & GPSDetections$time<=1503670355.877] = F

#The flight and airport stays are static
#Keep in mind we need to remove all 2 detection movements that are longer than 20 minutes for this to be ok.
GPSDetections$isMoving[GPSDetections$time>=1503820961.134 & GPSDetections$time<=1503847551.08] = F
