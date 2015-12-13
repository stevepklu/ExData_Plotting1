## plot 1 generation

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
hist(as.numeric(dat$GAP), xlab = "Global Active Power (kilowatts)", col = "red", 
     main = "Global Active Power")

## 3. Save Plot
dev.copy(png, file = "plot1.png")
dev.off()


