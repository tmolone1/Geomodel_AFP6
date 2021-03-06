# the `plot_ly()` function initiates an object, and if no trace type
# is specified, it sets a sensible default
p <- plot_ly(economics, x = ~date, y = ~uempmed)
p

# some `add_*()` functions are a specific case of a trace type
# for example, `add_markers()` is a scatter trace with mode of markers
add_markers(p)

# scatter trace with mode of text
add_text(p, text = "%")

# scatter trace with mode of lines 
add_paths(p)

# like `add_paths()`, but ensures points are connected according to `x`
add_lines(p)

# if you prefer to work with plotly.js more directly, can always
# use `add_trace()` and specify the type yourself
add_trace(p, type = "scatter", mode = "markers+lines")

# mappings provided to `plot_ly()` are "global", but can be overwritten
plot_ly(economics, x = ~date, y = ~uempmed, color = I("red"), showlegend = FALSE) %>% 
  add_lines() %>%
  add_markers(color = ~pop)

# a number of `add_*()` functions are special cases of the scatter trace
plot_ly(economics, x = ~date) %>% 
  add_ribbons(ymin = ~pce - 1e3, ymax = ~pce + 1e3)

# use `group_by()` (or `group2NA()`) to apply visual mapping
# once per group (e.g. one line per group)
txhousing %>% 
  group_by(city) %>% 
  plot_ly(x = ~date, y = ~median) %>%
  add_lines(color = I("black"))

## Not run: 
# use `add_sf()` or `add_polygons()` to create geo-spatial maps
# http://blog.cpsievert.me/2018/03/30/visualizing-geo-spatial-data-with-sf-and-plotly/
if (requireNamespace("sf", quietly = TRUE)) {
  nc <- sf::st_read(system.file("shape/nc.shp", package = "sf"), quiet = TRUE)
  plot_ly() %>% add_sf(data = nc)
}

# univariate summary statistics
plot_ly(mtcars, x = ~factor(vs), y = ~mpg) %>% 
  add_boxplot()
plot_ly(mtcars, x = ~factor(vs), y = ~mpg) %>% 
  add_trace(type = "violin")

# `add_histogram()` does binning for you...
mtcars %>%
  plot_ly(x = ~factor(vs)) %>%
  add_histogram()

# ...but you can 'pre-compute' bar heights in R
mtcars %>%
  dplyr::count(vs) %>%
  plot_ly(x = ~vs, y = ~n) %>%
  add_bars()

# the 2d analogy of add_histogram() is add_histogram2d()/add_histogram2dcontour()
library(MASS)
(p <- plot_ly(geyser, x = ~waiting, y = ~duration))
add_histogram2d(p)
add_histogram2dcontour(p)

# the 2d analogy of add_bars() is add_heatmap()/add_contour()
# (i.e., bin counts must be pre-specified)
den <- kde2d(geyser$waiting, geyser$duration)
p <- plot_ly(x = den$x, y = den$y, z = den$z)
add_heatmap(p)
add_contour(p)

# `add_table()` makes it easy to map a data frame to the table trace type
plot_ly(economics) %>% 
  add_table()

# pie charts!
ds <- data.frame(labels = c("A", "B", "C"), values = c(10, 40, 60))
plot_ly(ds, labels = ~labels, values = ~values) %>%
  add_pie() %>%
  layout(title = "Basic Pie Chart using Plotly")

data(wind)
plot_ly(wind, r = ~r, t = ~t) %>% 
  add_area(color = ~nms) %>%
  layout(radialaxis = list(ticksuffix = "%"), orientation = 270)

# ------------------------------------------------------------
# 3D chart types
# ------------------------------------------------------------
plot_ly(z = ~volcano) %>% 
  add_surface()
plot_ly(x = c(0, 0, 1), y = c(0, 1, 0), z = c(0, 0, 0)) %>% 
  add_mesh()

## End(Not run)