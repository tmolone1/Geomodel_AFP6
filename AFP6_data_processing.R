library(raster)
library(readr)
library(dplyr)
library(inlmisc)
library(tidyverse)
collar<-read_csv("M:/ItoN/MidnightSunTrinityJV/Modeling/AFP6/Leapfrog/Exports/collar_new.csv")
lith<-read_csv("M:/ItoN/MidnightSunTrinityJV/Modeling/AFP6/Well Data/tbl3_lith_bri.csv")

merged<-merge(collar,lith,by=1)
t<-merged %>% filter(Lithology=='Top of Rock') %>% dplyr::select(c(LOCID,ECOORD,NCOORD,ELEV,value)) %>% mutate(z=ELEV-value)
pwr<- merged %>% filter(Lithology=='PWR') %>% dplyr::select(c(LOCID,ECOORD,NCOORD,ELEV,value)) %>% mutate(pwr_z=ELEV-value)
merge2<-merge(t,pwr,by=1) %>% mutate(pwr_thick=pwr_z-z)

#bedrock_surface
x<-t$ECOORD
y<-t$NCOORD
z<-t$z  


coords<-CRS("+init=epsg:27200")  # make sure to comment whatever coordinate system this is
buff<-100 # feet to extend the raster beyond the points
r73<-mygrid(x,y,z,buff,coords)
pts<-mypts(x,y,z,coords)
conts<-mycontours(r73, seq(900,1080,15))

#PWR thickness
x<-merge2$ECOORD.x
y<-merge2$NCOORD.x
z<-merge2$pwr_thick

coords<-CRS("+init=epsg:27200")  # make sure to comment whatever coordinate system this is
buff<-100 # feet to extend the raster beyond the points
r74<-mygrid(x,y,z,buff,coords)
pts<-mypts(x,y,z,coords)
conts<-mycontours(r74, seq(0,75,15))


PlotMap(r74)
points(pts)
lines(conts)


