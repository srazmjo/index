rm(list=ls(all = TRUE))

# install.packages("tidyverse", dependencies = TRUE)
# install.packages("sf", dependencies = TRUE)
# install.packages("raster", dependencies = TRUE)
# install.packages("doParallel", dependencies = TRUE)
# install.packages("snow", dependencies = TRUE)

library(sf)
library(tidyverse)
library(raster)
library(doParallel)
library(snow)

setwd("C:/Users/alyss/Desktop/my r script/data")

cri_pop19 <- raster("world_pop/cri_ppp_2019.tif")
cri_adm1 <- read_sf("costa_rica/gadm36_CRI_1.shp")
cri_adm2 <- read_sf("costa_rica/gadm36_CRI_2.shp")
cri_adm3  <- read_sf("costa_rica/gb20_CRI_3.shp")

cri_pop19
cri_adm1
plot(st_geometry(cri_adm3))

plot(cri_pop19)
plot(st_geometry(cri_adm1), add = TRUE)

#ncores <- detectCores() - 1
# beginCluster(ncores)
# pop_vals_adm1 <- raster::extract(cri_pop19, cri_adm1, df = TRUE)
# endCluster()

# save(pop_vals_adm1, file = "pop_vals_adm1.RData")
load("pop_vals_adm1.RData")

# ncores <- detectCores() - 1
# beginCluster(ncores)
# pop_vals_adm2 <- raster::extract(cri_pop19, cri_adm2, df = TRUE)
# endCluster()

# save(pop_vals_adm2, file = "pop_vals_adm2.RData")
load("pop_vals_adm2.RData")

# ncores <- detectCores() - 1
# beginCluster(ncores)
# pop_vals_adm3 <- raster::extract(cri_pop19, cri_adm3, df = TRUE)
# endCluster()

# save(pop_vals_adm3, file = "pop_vals_adm3.RData")
load("pop_vals_adm3.RData")
#######################################

# cri_adm3_rev <- cri_adm3 %>%
#   filter(shapeName != "Cocos Island")
 
# plot(st_geometry(cri_adm3_rev))

plot(cri_pop19)
plot(st_geometry(cri_adm2), add = TRUE)
plot(st_geometry(cri_adm3), add = TRUE)
plot(st_geometry(cri_adm1), add = TRUE)


totals_adm1 <- pop_vals_adm1 %>%
  group_by(ID) %>%
  summarize(cri_pop19 = sum(cri_ppp_2019, na.rm = TRUE))

totals_adm2 <- pop_vals_adm2 %>%
  group_by(ID) %>%
  summarize(cri_pop19 = sum(cri_ppp_2019, na.rm = TRUE))

totals_adm3 <- pop_vals_adm3 %>%
  group_by(ID) %>%
  summarize(cri_pop19 = sum(cri_ppp_2019, na.rm = TRUE))

mycri_adm1 <- cri_adm1 %>%
  add_column(pop19 = totals_adm1$cri_pop19)

mycri_adm2 <- cri_adm2 %>%
  add_column(pop19 = totals_adm2$cri_pop19)

mycri_adm3 <- cri_adm3 %>%
  add_column(pop19 = totals_adm3$cri_pop19)



ggplot(mycri_adm2) +
  geom_sf(aes(fill = log(pop19))) +
  geom_sf_text(aes(label = NAME_2),
               color = "black",
               size = 1) +
  scale_fill_gradient(low = "floralwhite", high = "firebrick1")

ggsave("cri_pop19_logpop.png")

sum(totals_adm1$cri_pop19)
# (4747776)
######################################

ggplot() +
  geom_sf(data = mycri_adm1,
          aes(fill = log(pop19)),
          size=.1) +
  geom_sf_text(data = mycri_adm1,
          aes(label = NAME_1),
               color = "black",
               size = 2.5, alpha = 0) +
  geom_sf(data = mycri_adm2,
          aes(fill=log(pop19)),
          size=.65)+
  geom_sf_text(data = mycri_adm2,
         aes(label = NAME_2),
               color= "black",
               size= 1, alpha = .6) +
  scale_fill_gradient2(low = "blue", mid="yellow", high="red", midpoint = 10.5)

ggsave("cri_pop19_str2.png")

######################################

title(main = "Costa Rica Population by Districts", xlab = "longitude", ylab = "latitude")