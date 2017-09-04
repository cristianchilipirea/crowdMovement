GPSDetections2 = GPSDetections2[!duplicated(GPSDetections2$time),]

#calculate isMoving here

GPSDetections2$isMoving = c(F, GPSDetections2$isMoving[-nrow(GPSDetections)]) | GPSDetections2$isMoving

# zilverling is static
GPSDetections2$isMoving[GPSDetections2$time>=1504180583 & GPSDetections2$time<=1504184351] = F


#utrecht central is static
GPSDetections2$isMoving[GPSDetections2$time>=1504163468 & GPSDetections2$time<=1504174002] = F

#Kerl V is static
GPSDetections2$isMoving[GPSDetections2$time>=1504111750 & GPSDetections2$time<=1504122089] = F

#Snellius is static
GPSDetections2$isMoving[GPSDetections2$time>=1504102795 & GPSDetections2$time<=1504106005] = F

#AH is static
GPSDetections2$isMoving[GPSDetections2$time>=1504291182 & GPSDetections2$time<=1504293665] = F
