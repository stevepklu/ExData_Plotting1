## plot 3 generation

## 1. Read Data
filename <- "household_power_consumption.txt"

con <- file(filename)
open(con)

x <- scan(con, what = "character", nline = 1, quiet = T)
dat <- data.frame(Date = character(0), 
                  Time = character(0),
                  GAP = numeric(0),
                  GRP = numeric(0),
                  Volt = numeric(0),
                  GInt = numeric(0),
                  SM1 = numeric(0),
                  SM2 = numeric(0),
                  SM3 = numeric(0), stringsAsFactors=F)

lastdate <- strptime("02/02/2007", "%d/%m/%Y")

repeat{
    x <- scan(con, what = list("", "", "", "", "", "", "", "", ""), nline = 1, quiet = T, sep = ";")
    names(x) <- colnames(dat)
    
    if (strptime(x$Date, "%d/%m/%Y") > lastdate || length(x) == 0) 
        break
    if (x$Date == "1/2/2007" || x$Date == "2/2/2007") 
        dat <- rbind(dat, data.frame(x, stringsAsFactors=F))
    
}
close(con)

## 2. Make plot
plot_color <- c("black", "red", "blue")
plot(dat$SM1, type = "n", xlab = "DateTime", ylab = "Energy sub metering", xaxt = "n")
axis(1, at = c(0, 1440, 2880), labels = c("Thu", "Fri", "Sat"))
lines(dat$SM1, col = plot_color[1])
lines(dat$SM2, col = plot_color[2])
lines(dat$SM3, col = plot_color[3])
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex=0.9, col=plot_color, 
       lty=c(1, 1, 1), lwd=1)


## 3. Save Plot
dev.copy(png, file = "plot3.png")
dev.off()


