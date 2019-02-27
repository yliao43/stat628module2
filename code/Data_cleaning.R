dat <- read.csv('/Users/tete/628data/bus_food.csv',header = T)

flag <- vector()
for(i in 1:nrow(dat)){
  if(dat[i, 'ratings'] == -1){
    flag <- append(flag, i)
  }
}
dat <- dat[-flag,]

char_flag <- c('X', 'hours', 'categories', 'latitude', 'longitude', 'postal_code', 
          'business_id', 'name', 'city', 'HairSpecializesIn')
num_flag <- vector()
for(i in 1:ncol(dat)){
  if(names(dat)[i] %in% char_flag){
    num_flag <- append(num_flag, i)
  }
}
dat <- dat[, -num_flag]

single_factor_flag <- vector()
for(i in 1:ncol(dat)){
  if(class(dat[, i]) == 'logical'){
    dat[, i] <- as.factor(dat[, i])
  }
  if((class(dat[, i]) == 'factor')&&(length(levels(dat[, i])) == 1)){
    single_factor_flag <- append(single_factor_flag, i)
  }
}
dat[, 'is_open'] <- as.factor(dat[, 'is_open'])
dat[, 'RestaurantsPriceRange2'] <- as.factor(dat[, 'RestaurantsPriceRange2'])

freq_NA <- vector(length = 57)
flag_NA <- vector()
for(i in 1:(ncol(dat)-1)){
  freq_NA[i] <- sum(is.na(dat[, i]))/nrow(dat)
  if(freq_NA[i] > 0.7){
    flag_NA <- append(flag_NA, i)
  }
}
dat <- dat[, -flag_NA]

dat$Alcohol <- as.character(dat$Alcohol)
dat$Alcohol <- sub("u'", "'", dat$Alcohol)
dat$Alcohol <- as.factor(dat$Alcohol)

dat$NoiseLevel <- as.character(dat$NoiseLevel)
dat$NoiseLevel <- sub("u'", "'", dat$NoiseLevel)
dat$NoiseLevel <- as.factor(dat$NoiseLevel)

dat$RestaurantsAttire <- as.character(dat$RestaurantsAttire)
dat$RestaurantsAttire <- sub("u'", "'", dat$RestaurantsAttire)
dat$RestaurantsAttire <- as.factor(dat$RestaurantsAttire)

dat$WiFi <- as.character(dat$WiFi)
dat$WiFi <- sub("u'", "'", dat$WiFi)
dat$WiFi <- as.factor(dat$WiFi)

write.csv(dat, '/Users/tete/628data/cleaned_without_reivews.csv', row.names = F)


