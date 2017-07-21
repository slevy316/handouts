## Importing vector data

library(sf)
library(rgdal)

shp <- 'data/cb_2016_us_county_5m'                       ## bringing it into R
counties <- st_read(shp, stringsAsFactors = FALSE)       ## st_read turns into useable data (eg character>dataframe) 

class(shp)

st_crs(counties)                                         ## give the Coordinate Ref System (CRS)

## Bounding box

names(counties)

library(dplyr)                                           ## dplyr = data manipulation
counties_md <- filter(counties, STATEFP == "24")         ## filtering a subset

plot(counties_md$geometry)                               ## to plot spatial data use the geom data

## Grid

grid_md <- st_make_grid(counties_md, n = 4)              ## create polygon grid

grid_md                                                  ## stored as a set of polygons
st_bbox(grid_md)                                         ## should have same extent


## Plot layers

plot(grid_md)                                            ## just the grid
plot(counties_md$geometry, add = T)                      ## add = T key to get multiple layers

plot(counties_md[ ,"ALAND"])                             ## colours! overwrites as no add = T

## Create geometry                                       ## important as so many different systems, R may fix it for you, but you want to safeguard

sesync <- st_sfc(
    st_point(c(-76.503394, 38.976546)),
        crs = 4326)


counties_md <- st_transform(counties_md,                ## re-projects the counties dataframe
                            crs = st_crs(sesync))
plot(counties_md$geometry)
plot(sesync, col = "green", pch = 20, add = T)

##subsetting vector data

st_within(sesync, counties_md)                         ## only worked as had created geometry + areas are close together, use st_area etc. to help correct

## Exercise 1: Produce a map of Maryland counties 
##             with the county that contains SESYNC 
##             colored in red.

st_within(sesync, counties_md)                                       ## ans = 5 can also store it (see alternative way 2)

plot(counties_md$geometry)
plot(counties_md[5, ], col = "red", add = T)                         ## counties_md[5, ] analagous to counties$geometry[5]
plot(sesync, col = 'green', pch = 20, add = TRUE)

plot(counties_md$geometry)                                           ## alternative way 1
plot(counties_md[sesync, ], col = "black", border = "red", add = T)  ## can also change border colour
plot(sesync, col = 'green', pch = 20, add = TRUE)

plot(counties_md$geometry)                                           ## alternative way 2
overlay	<- st_within(sesync, counties_md)
counties_sesync <- counties_md[overlay[[1]], 'geometry']
plot(counties_sesync, col = "red", add = TRUE)
plot(sesync, col = 'green', pch = 20, add = TRUE)

## Coordinate transforms

shp <- 'data/huc250k'
huc <- st_read(shp)
plot(huc$geometry)

st_crs(huc)                                                     ## get the project string towards end of str(), key for next step

prj <- '+proj=aea +lat_1=29.5 +lat_2=45.5 +lat_0=23 +lon_0=-96 +x_0=0 +y_0=0 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs'

counties_md <- st_transform(counties_md, crs=prj)

huc <- st_transform(huc, crs = prj)                             ## getting into same crs format
sesync <- st_transform(sesync, crs = prj)
plot(counties_md$geometry)
plot(huc, border = 'blue', add = TRUE)
plot(sesync, col = 'green', pch = 20, add = TRUE)

## Geometric operations on vector layers

state_md <- st_union(counties_md)                             ## st_union is an aggregate function, creates single shape
plot(state_md)                                                ## look at that, just one vector!

huc_md <- st_intersection(huc, state_md)                      ## clips national county data to vector set 
plot(huc_md, border = 'blue', col = NA, add = TRUE)

# st_buffer() can give you a buffer around a shapefile (such as MD), line type set with lty =

## Exercise 2: make a 5km buffer around MD with a dotted line


...


## Working with raster data                                  ## raster data is grid of interconnected data (norm spatial)

library(raster)
nlcd <- raster("data/nlcd_agg.grd")
class(nlcd)

plot(nlcd)
plot(huc_md, add = T)

## Crop                                                     ### CHECK OUT RSPATIAL.ORG 

extent <- matrix(st_bbox(huc_md), nrow = 2)                 ## need to convert huc layer into something that raster package will understand
nlcd <- crop(nlcd, extent)                                  ## crop shapefiles to match another layer
plot(nlcd)            
plot(state_md, add = T)

## Raster data attributes

lc_types <- nlcd@data@attributes[[1]]$Land.Cover.Class

lc_types

## Raster math

pasture <- mask(nlcd, nlcd == 81, maskvalue = FALSE)     ## mask is how you pull out just one type of value (here it is pastureland) can do multiple by selecting c(81, 82, etc)
plot(pasture)                                            ## reclassify can be used to unite layers together if required


nlcd_agg <- aggregate(nlcd, fact = 25, fun = modal)      ## aggregating pixels by 25x
nlcd_agg@legend <- nlcd@legend
plot(nlcd_agg)

res(nlcd)                                                ## checking the resolution
res(nlcd_agg)

## Exercise 3

...

## Mixing rasters and vectors: prelude

sesync <- as(sesync, "Spatial")                         ## as() "coerces" objects into another type
huc_md <- as(huc_md, "Spatial")
counties_md <- as(counties_md, "Spatial")

## Mixing rasters and vectors

plot(nlcd)
plot(sesync, col = 'green', pch = 16, cex = 2, add = T)

sesync_lc <- extract(nlcd, sesync)
class(sesync_lc)                                       ## could be either matrix or numeric depending on whether single point or multiple. This is single point (23) so numeric

county_nlcd <- extract(nlcd_agg, counties_md[1, ])
tables_county_nlcd

modal_lc <- extract(nlcd_agg, huc_md, fun = modal)

... <- lc_types[modal_lc + 1]

